Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbTJOO1l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 10:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263265AbTJOO1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 10:27:41 -0400
Received: from users.linvision.com ([62.58.92.114]:27071 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262608AbTJOO1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 10:27:39 -0400
Date: Wed, 15 Oct 2003 16:27:38 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Josh Litherland <josh@temp123.org>, linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031015142738.GG24799@bitwizard.nl>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <16269.20654.201680.390284@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16269.20654.201680.390284@laputa.namesys.com>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 05:50:38PM +0400, Nikita Danilov wrote:
> Erik Mouw writes:
>  > Nowadays disks are so incredibly cheap, that transparent compression
>  > support is not realy worth it anymore (IMHO).
> 
> But disk bandwidth is so incredibly expensive that compression becoming
> more and more useful: on compressed file system bandwidth of user-data
> transfers can be larger than raw disk bandwidth. It is the same
> situation as with allocation of disk space for files: disks are cheap,
> but storing several files in the same block becomes more advantageous
> over time.

You have a point, but remember that modern IDE drives can do about
50MB/s from medium. I don't think you'll find a CPU that is able to
handle transparent decompression on the fly at 50MB/s, even not with a
simple compression scheme as used in NTFS (see the NTFS docs on
SourceForge for details).


Erik

PS: let me guess: among other things, reiser4 comes with transparent
    compression? ;-)

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com

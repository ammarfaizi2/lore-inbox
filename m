Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTJOQEe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 12:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTJOQEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 12:04:33 -0400
Received: from users.linvision.com ([62.58.92.114]:26818 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261973AbTJOQEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 12:04:32 -0400
Date: Wed, 15 Oct 2003 18:04:31 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Josh Litherland <josh@temp123.org>, linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031015160430.GH24799@bitwizard.nl>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <16269.20654.201680.390284@laputa.namesys.com> <20031015142738.GG24799@bitwizard.nl> <16269.23199.833564.163986@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16269.23199.833564.163986@laputa.namesys.com>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 06:33:03PM +0400, Nikita Danilov wrote:
> Erik Mouw writes:
>  > You have a point, but remember that modern IDE drives can do about
>  > 50MB/s from medium. I don't think you'll find a CPU that is able to
>  > handle transparent decompression on the fly at 50MB/s, even not with a
>  > simple compression scheme as used in NTFS (see the NTFS docs on
>  > SourceForge for details).
> 
> Trend is that CPU is getting faster and faster with respect to the
> disk. So, even if it were hard to find such a CPU to-day, it will be
> common place to-morrow.

I'm not too sure about this. It's my feeling that CPU speed and disk
throughput grow about as fast. I don't have hard figures, so I can be
proven wrong on this.

FYI: you hardly see compressed files on NTFS. If you do, it's either
because the user thought it was a fun feature (in which case only a
small amount of files are compressed), or because it's an old (small)
disk filled to the brim with data (in which case most of the volume is
compressed). In the latter case compression indeed makes things faster,
but only when using the disk with a modern CPU, not when using it in
the original machine.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com

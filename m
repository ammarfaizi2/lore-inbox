Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbTJONul (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 09:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263248AbTJONul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 09:50:41 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:1182 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S263244AbTJONuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 09:50:40 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16269.20654.201680.390284@laputa.namesys.com>
Date: Wed, 15 Oct 2003 17:50:38 +0400
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Josh Litherland <josh@temp123.org>, linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
In-Reply-To: <20031015133305.GF24799@bitwizard.nl>
References: <1066163449.4286.4.camel@Borogove>
	<20031015133305.GF24799@bitwizard.nl>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw writes:
 > On Tue, Oct 14, 2003 at 04:30:50PM -0400, Josh Litherland wrote:
 > > Are there any filesystems which implement the transparent compression
 > > attribute ?  (chattr +c)
 > 
 > The NTFS driver supports compressed files. Because it doesn't have
 > proper write support, I don't think it will do anything useful with
 > chattr +c.
 > 
 > Nowadays disks are so incredibly cheap, that transparent compression
 > support is not realy worth it anymore (IMHO).

But disk bandwidth is so incredibly expensive that compression becoming
more and more useful: on compressed file system bandwidth of user-data
transfers can be larger than raw disk bandwidth. It is the same
situation as with allocation of disk space for files: disks are cheap,
but storing several files in the same block becomes more advantageous
over time.

 > 
 > 
 > Erik
 > 

Nikita.

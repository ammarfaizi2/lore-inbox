Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbUACSHL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 13:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbUACSHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 13:07:11 -0500
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:6750 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263620AbUACSHJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 13:07:09 -0500
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: linux-kernel@vger.kernel.org
Subject: Re: [NEW FEATURE]Partitions on loop device for 2.6
Date: Sat, 3 Jan 2004 19:05:42 +0100
User-Agent: KMail/1.5
References: <200312241341.23523.blaisorblade_spam@yahoo.it> <3FF5DCE8.4020008@tmr.com>
In-Reply-To: <3FF5DCE8.4020008@tmr.com>
Cc: Bill Davidsen <davidsen@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200401031905.42584.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 22:04, venerdì 2 gennaio 2004, Bill Davidsen ha scritto:
> BlaisorBlade wrote:
> > NEED:
> > I have the need to loop mount files containing not plain filesystems, but
> > whole disk images.
> >
> > This is especially needed when using User-mode-linux, since to run any
> > distro installer you must partition the virtual disks(and on the host,
> > the backing file of the disk contains a partition table).
> >
> > Currently this could be done by specifying a positive offset, but letting
> > the kernel partition code handle this is better, isn't it? Would you ever
> > accept this feature into stock kernel?
>
> UML is on my list of things to learn (as opposed to "try casually and
> ignore")
It is something a bit like VMWare. But instead of emulating hardware and 
running an OS inside that, you run a patched Linux kernel that runs as an 
userspace process on the host and provides a virtual machine, which must 
access a virtual disk, which is stored on a file.
See http://user-mode-linux.sourceforge.net/ for more info.
> but have you considered using NBD?
I didn't really know what it was, nor it seems useful for this "as is" (I've 
not really checked). Maybe that sentence means that the server program could 
do the partition parsing?
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN


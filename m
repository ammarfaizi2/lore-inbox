Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUJOAXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUJOAXS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 20:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266748AbUJOAWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 20:22:38 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:36814 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S267515AbUJOATj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 20:19:39 -0400
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: LKML <linux-kernel@vger.kernel.org>
Date: Fri, 15 Oct 2004 10:19:36 +1000
Subject: Re: Linux-2.6.8 Hates DOS partitions
Message-ID: <20041015001936.GB26145@cse.unsw.EDU.AU>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0410131329110.3818@chaos.analogic.com> <20041013213519.GA3379@pclin040.win.tue.nl> <Pine.LNX.4.61.0410131833370.12624@chaos.analogic.com> <200410142045.28449.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410142045.28449.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis

On Thu, 14 Oct 2004, Denis Vlasenko wrote:

> > I just had to reinstall the "Fedora Linux 2" release from scratch the
> > second time. What it does is, even though I told it to leave my
> > SCSI disks alone, and even though I bought a new ATA Disk just for
> > it, and even though I carefully told the installation program to
> > use ONLY /dev/hda... Guess what? It installed a piece of GRUB
> > on my first SCSI, /dev/sda, where the LILO boot-loader for DOS
> > and linux-2.4.26 exists! It looks like it put it in a partition
> > table!
> > 
> > So, every time I install a new Linux version, GRUB writes something
> > else there. Eventually it probably gets big enough to make the DOS D: 
> > partition go away, and soon DOS drive C: becomes unbootable. I can't
> > find any other reason.
> 
> If you want to be sure that DOS boots, you may boot Linux by booting
> into DOS first and then use loadlin/linld. I do it all the time.
> 
> > This is the second time I've had to reinstall everything from
> > scratch in the past two weeks and I can tell you that there is
> > nothing "free" about free software.
I think you are misinterpreting "free", for example:
http://www.gnu.org/philosophy/philosophy.html#AboutFreeSoftware

is a good start, it has nothing to do with $$$$$ :)

> 
> Bullshit. Commercial software can mess things up too.
> 
> Two weeks ago I personally witnessed how simple chkdsk
> (standard one from NT install CD, not a fancy utility)
> mangled NT4 domain controller's mirrored boot partition
> to the point of "inaccessible boot device" BSOD.
> 
> It was not fun at all. Luckily I had a complete backup.
> --
> vda
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------

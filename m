Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277985AbRJOCtr>; Sun, 14 Oct 2001 22:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277986AbRJOCth>; Sun, 14 Oct 2001 22:49:37 -0400
Received: from mx01-a.netapp.com ([198.95.226.53]:29383 "EHLO
	mx01-a.netapp.com") by vger.kernel.org with ESMTP
	id <S277985AbRJOCtX>; Sun, 14 Oct 2001 22:49:23 -0400
Date: Sun, 14 Oct 2001 19:49:13 -0700 (PDT)
From: Kip Macy <kmacy@netapp.com>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Cyrus <cyrus@linuxmail.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Large Storage Devices in Linux.....Kernel level support.....
In-Reply-To: <20011014192542.C28547@mikef-linux.matchmail.com>
Message-ID: <Pine.GSO.4.10.10110141947400.18511-100000@orbit-fe.eng.netapp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

S.M.A.R.T. and SMART are not the same thing. A quick google search got me
to this page:
 
<http://www.belarc.com/Images/blank.gif>
[About S.M.A.R.T.]
S.M.A.R.T. (Self-Monitoring Analysis and Reporting Technology) is a
diagnostic method originally developed by I.B.M. for their mainframe
drives to give advanced warning of drive failures. Large mainframe data
centers wanted to know in advance if a hard disk drive was going to fail,
because this gave them the opportunity to take steps to protect their
data. Later Compaq announced a diagnostic which operated with a number of
different disk drive manufacturers. These products were submitted to the
ATA/IDE standards committees and the resulting standard was named
S.M.A.R.T. Today all major hard disk drive manufacturers support
S.M.A.R.T., including IBM, Western Digital, Quantum, Seagate, and Fujitsu.
etc.


On Sun, 14 Oct 2001, Mike Fedyk wrote:

> On Sun, Oct 14, 2001 at 05:24:59PM +1000, Cyrus wrote:
> > hi all,
> > 
> > i've got a setup of 2 hard drives (30GB & 40GB) with an Asus a7m266 mobo 
> > with a VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06).
> > 
> > 30GB= fujitsu, 40GB= IBM (both are 7200rpm
> > 
> > i've got my cdrw on /dev/hdc, 30GB=/dev/hda, and 40GB=/dev/hdb...
> > 
> > all works alright for a while, but when i keep my computer turned on for 
> > a couple of days and then reboot. bios sometimes tells me that smart 
> > array (or something) failed with my primary master (30GB) and i should 
> > back-up soon.. next reboot it tells me that pri-master fails.. it's 
> > doing this quite regularly and i don't know how to stop it. i'm running 
> 
> Turn off "S.M.A.R.T." in your bios...  Probably under the advanced bios
> config menu.
> 
> I know that Compaq has a SMART RAID controller, but does anyone know what
> this does?  (I've seen it on old p2 MBs and they didn't have raid...)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


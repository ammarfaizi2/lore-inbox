Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274122AbRISRwU>; Wed, 19 Sep 2001 13:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274123AbRISRwL>; Wed, 19 Sep 2001 13:52:11 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:65041 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S274122AbRISRwA>; Wed, 19 Sep 2001 13:52:00 -0400
Date: Wed, 19 Sep 2001 19:52:11 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: "Randy.Dunlap" <rddunlap@osdlab.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, crutcher+kernel@datastacks.com,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Magic SysRq +# in 2.4.9-ac/2.4.10-pre12
Message-ID: <20010919195211.F7179@arthur.ubicom.tudelft.nl>
In-Reply-To: <3BA8C01D.79FBD7C3@osdlab.org> <20010919193105.E7179@arthur.ubicom.tudelft.nl> <3BA8D723.51F17211@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA8D723.51F17211@osdlab.org>; from rddunlap@osdlab.org on Wed, Sep 19, 2001 at 10:34:27AM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 10:34:27AM -0700, Randy.Dunlap wrote:
> Erik Mouw wrote:
> > Same over here with an IBM PS/2 keyboard that originally came with an
> > IBM PS2 model 55SX. The IBM keyboard is connected to an Asus M8300
> > laptop. The keyboard of that laptop has the interesting "feature" that
> > Alt-SysRQ-m sets the loglevel to 0, and Alt-SysRQ-[suob] also set the
> > loglevel to a different value instead of doing their job.
> 
> I'm having this (my same) problem on a different test system/keyboard,
> and I'm beginning to think that it's not a keyboard problem,
> but I don't have any evidence of that one way or the other.
> 
> I've tested 2.4.2, 2.4.5, 2.4.6, 2.4.7, 2.4.9, and 2.4.10-pre,
> and all exhibit the same problem.

Two other data points:

Desktop PC (Asus P5A motherboard, AMD K6/333) and Happy Hacking Lite
keyboard: only Alt-SysRQ-[sm] work, all other don't (unmount, off, and
reboot not tested, though). Kernel is 2.4.9-ac10.

LART StrongARM SA1100 board, serial console (sa1100 driver), kernel
2.4.9-ac9-rmk1-np1 (latest stable release for StrongARM machines):
everything works.

The evidence with the ARM board points in the direction of the keyboard
driver. I don't have a null modem cable right here so I can't test the
desktop with a serial console, but that would also give an interesting
data point.


Erik

PS: my laptop also runs 2.4.9-ac10

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/

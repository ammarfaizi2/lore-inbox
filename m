Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266347AbUHTLqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266347AbUHTLqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 07:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266569AbUHTLqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 07:46:24 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:45480 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S266347AbUHTLpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 07:45:49 -0400
Date: Fri, 20 Aug 2004 13:45:31 +0200
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       EdHamrick@aol.com
Subject: Consistent complete lock up with 2.6.8.1-mm2 and vuescan, no serial console output
Message-ID: <20040820114531.GA11463@gamma.logic.tuwien.ac.at>
References: <20040809185018.GA26084@gamma.logic.tuwien.ac.at> <20040812204756.GA12117@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040812204756.GA12117@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, hi Ed, hi list!

The problem persisted with 2.6.8.1-mm2, but this time a collected the
syslog via a usb serial console on my Palm T|C.

The funny thing is, only the normal syslog shows up, but there is no
error spewed out when X freezes.

Is there any chance to get *more* information via the serial console
(without usb)? If yes, I will search and hopefully can set up an old
TRGpro for receiving this stuff via teh serial port.

Anyway it would be nice to hear at least a comment from one of you on
how to proceed with this. Since it is 100% repeatable here, it would be
nice if it can be fixed. It suprises me that the whole kernel just
completely freezes, while only disk io and cpu is used, there is no
usage of usb stuff (besides the usb serial console, but also wihtout
it), vuescan is scanning from raw files, so not contacting any `outside'
world besides the hard drives.

Best wishes

Norbert

On Don, 12 Aug 2004, preining wrote:
> The problem persisted with 2.6.8-rc4-mm1, always (repeatable 100%) after
> around 30 scans the computer freezes completely. Not even sysrq works.
> 
> But at least what I could check was that it is not a memory problem,
> there is still enough swap free (close to 1G).
> 
> So what can I do, any ideas?
> 
> On Mon, 09 Aug 2004, preining wrote:
> > I have a bit of a problem here: I am scanning with vuescan (latest
> > version) on linux-2.6.8-rc3-mm1 a lot of images from raw files, i.e.
> > only data io from the hard disk, no usb etc interferes, and always after
> > 20/30 something images the computer freezes completely. Not even Sysrq
> > works. Only reset button. Of course, the syslog shows up nothing.
> > 
> > Is there anything you two can think of what could be the reason?
> > 
> > (and no, I have no chance to use serial console, but I doubt it would be
> > useful)
> 
> Best wishes
> 
> Norbert
> 
> -------------------------------------------------------------------------------
> Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
> gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
> -------------------------------------------------------------------------------
> CORSTORPHINE (n.)
> A very short peremptory service held in monasteries prior to teatime
> to offer thanks for the benediction of digestive biscuits.
> 			--- Douglas Adams, The Meaning of Liff

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
STURRY (n.,vb.)
A token run. Pedestrians who have chosen to cross a road immediately
in front of an approaching vehicle generally give a little wave and
break into a sturry. This gives the impression of hurrying without
having any practical effect on their speed whatsoever.
			--- Douglas Adams, The Meaning of Liff

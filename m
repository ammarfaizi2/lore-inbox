Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280646AbRKFWjs>; Tue, 6 Nov 2001 17:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280647AbRKFWji>; Tue, 6 Nov 2001 17:39:38 -0500
Received: from iris.ncsl.nist.gov ([129.6.57.209]:6784 "EHLO
	iris.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id <S280646AbRKFWjb>; Tue, 6 Nov 2001 17:39:31 -0500
Date: Tue, 6 Nov 2001 17:39:30 -0500
From: Martial MICHEL <martial@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.14 -- boot stop at "usb.c: registered new driver iforce"
Message-ID: <20011106173930.A2086@iris.ncsl.nist.gov>
Reply-To: Martial MICHEL <martial@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Ok ...  after   having  finished recompiling   2.4.14  without
"loopback device" (compilation problem explained in another e-mail), I
did  restart my system ...  and  it is booting properly until printing
the following line : "usb.c: registered  new driver iforce" (this line
appears with or  without the joystick  being connected to  the system)
and simply hang there indefenitely.

After a couple of testing (the scheduling process from 2.4.8-ac12 told
me that RTC  was the next lauch process)  I was able to  identify that
the  problem  is really  inside the  "iforce"  driver,  without it the
system boots up properly.

One again , I  am running a SMP P3  700 on an  asus P2B-D with  1Gb of
memory.  I  can provide my .config if  it  can be  of some  help (just
e-mail me about it).

						Hope this helps,

-- 
  Martial MICHEL
E-mail    : martial@users.sourceforge.net
Home page : http://www.loria.fr/~michel/
PBM       : http://pbm.sourceforge.net/
DLC       : http://dlc.sourceforge.net/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276709AbRKDAQd>; Sat, 3 Nov 2001 19:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276751AbRKDAQX>; Sat, 3 Nov 2001 19:16:23 -0500
Received: from ns.arraycomm.com ([199.74.167.5]:36510 "HELO
	bastion.arraycomm.com") by vger.kernel.org with SMTP
	id <S276709AbRKDAQR>; Sat, 3 Nov 2001 19:16:17 -0500
Message-Id: <200111040016.fA40GER4010596@lester.arraycomm.com>
X-Mailer: exmh version 2.4 05/15/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: Re: 3ware 3dmd & 2.4.12-ac: Error: No Controllers Found
Cc: demarest@arraycomm.com
Reply-To: Timothy Demarest <demarest@arraycomm.com>
Organization: ArrayComm, Inc.
X-url: http://www.arraycomm.com
X-Face: )?{NA%l9H>K'M[ioZ<Y9]0Ks$1-r[owPRVTxa_wn[itp+Y,BRG_sKiNI3sX,]*\yJNN]#_&
 frV+6Nv~Q3(j:3n.8a#6?k)hU5j,Z*>s@Nd%.($`3'%ppn*~@nI[Zr~9ec8-i8@@U/lVB>\[J9ESNh
 a52]aP'[4Qw6*)yBu[V8-C#V%>oY^#o]H@Jn:3"0I2OQiDmeh/Xk1b311'wd`+9rJ=XMaruKy`UT
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Nov 2001 16:16:14 -0800
From: Timothy Demarest <demarest@arraycomm.com>
X-Filter-Version: 1.7 (lester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Jason> I just checked and found I'm having the same problem.  I'm at
  Jason> 2.4.12-ac5 plus LVM 1.0.1_rc4.  I have no idea what could be going
  Jason> on; I've been lost a couple of times in the 3ware driver without
  Jason> understanding much of what's going on in there.

The problem is still there in 2.4.13-ac5 and 2.4.13-ac7, with the same
symptom:

Nov  3 15:46:27 bertha 3dmd: ioctl(4) failed: No such device or address
Nov  3 15:46:27 bertha 3dm: 3dmd startup succeeded 

Although the web interface to 3dmd doesn't appear to find the controller,
everything else appears to work just fine.

Plain 2.4.13 (and earlier, at least 2.4.10 and 2.4.12) appear to be OK.

I'm running the 7.3.2 release of the firmware (7.3.2 FE7X 1.03.09.027) and
3dmd (1.10.00.020), and using the driver included with the kernel
releases. Interesting features: Escalade 7810 with 8 drives, dual processor
Athlon MP on a Tyan Tiger mb, Netgear GA620.

--
Timothy Demarest                      ArrayComm, Inc.  
demarest@arraycomm.com                2480 North 1st Street, Suite 200
http://www.arraycomm.com              San Jose, CA 95131



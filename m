Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130876AbRAAFcD>; Mon, 1 Jan 2001 00:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131004AbRAAFbx>; Mon, 1 Jan 2001 00:31:53 -0500
Received: from exit1.i-55.com ([204.27.97.1]:60660 "EHLO exit1.i-55.com")
	by vger.kernel.org with ESMTP id <S130876AbRAAFbj>;
	Mon, 1 Jan 2001 00:31:39 -0500
Message-ID: <3A500DE8.9755BA46@mailhost.cs.rose-hulman.edu>
Date: Sun, 31 Dec 2000 22:56:08 -0600
From: Leslie Donaldson <donaldlf@hermes.cs.rose-hulman.edu>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test12 alpha)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx 2.4.0 test12 hang
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  After some crashes this weekend I have tracked the crash to someplace
in 
tagged Command Queue.

I noticed 2.4.0 is in the prerelease phase So I will try to get a patch
out 
real soon now the when the 39160 is detected the driver will shut off
the TCQ.
At least then 2.4.0 will be stable, not fast, but stable :)

Now back to figureing out whats wrong in that thar code :)

Leslie Donaldson

P.S. If anyone has XFree 4.0.2 working on the Alpha drop me a line. I
snagged the
     latest RPM from rawhide but it can't load symbols .... sigh...


-- 
/----------------------------\ Current Contractor: None
|    Leslie F. Donaldson     | Current Customer  : None
|    Computer Contractor     | Skills:
Unix/OS9/VMS/Linux/SUN-OS/C/C++/assembly
| Have Computer will travel. | WWW  :
http://www.cs.rose-hulman.edu/~donaldlf
\----------------------------/ Email: mail://donaldlf@cs.rose-hulman.edu
Goth Code V1.1: GoCS$$ TYg(T6,T9) B11Bk!^1 C6b-- P0(1,7) M+ a24 n---
b++:+
                H6'11" g m---- w+ r+++ D--~!% h+ s10 k+++ R-- Ssw
LusCA++
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

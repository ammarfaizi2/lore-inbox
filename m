Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132295AbRBNOV4>; Wed, 14 Feb 2001 09:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132278AbRBNOVq>; Wed, 14 Feb 2001 09:21:46 -0500
Received: from fep02.swip.net ([130.244.199.130]:7357 "EHLO fep02-svc.swip.net")
	by vger.kernel.org with ESMTP id <S132277AbRBNOVe>;
	Wed, 14 Feb 2001 09:21:34 -0500
Message-ID: <3A8A5E30.79ABF884@linux.nu>
Date: Wed, 14 Feb 2001 11:30:09 +0100
From: Arvid Ericsson <aquid@linux.nu>
X-Mailer: Mozilla 4.5 [sv] (Win95; I)
X-Accept-Language: en-GB,sv,fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Memory performance significantly improved w/ 2.4.1ac11
Content-Type: multipart/mixed;
 boundary="------------78FE48C044846BF466EE274C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Detta är ett meddelande som består av flera delar i MIME-format.
--------------78FE48C044846BF466EE274C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi y'all!
 I thought someone might be interested in some stream results. Please
ignore me otherwise. I know you don't like attachments, but the text
plainly refuses to be cut and pasted in a proper way (posting from
Windows 95).
 Btw, Im not subscribed to the list. 

/Arvid
--------------78FE48C044846BF466EE274C
Content-Type: text/plain; charset=us-ascii;
 name="new streams"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="new streams"

STREAM

Tyan 1592S (VIA vt82c586b rev 0x41, 512Kb)
AMD K6-266 (66Mhzx4)
egcs-1.1.2 (g++ -O3 -march=pentium -funroll-loops)

2x32Mb (60ns, EDO SIMM):
	    Function      Rate (MB/s)   RMS time     Min time     Max time
	    Copy:          54.6566       0.2928       0.2927       0.2928
2.2.14	    Scale:         54.2420       0.2950       0.2950       0.2952
	    Add:           59.6669       0.4024       0.4022       0.4035
	    Triad:         59.0813       0.4063       0.4062       0.4070

	    Copy:          55.5657       0.2887       0.2879       0.2909
2.4.0ac10:  Scale:         54.9947       0.2916       0.2909       0.2934
	    Add:           60.5573       0.3974       0.3963       0.4002
	    Triad:         59.9713       0.4013       0.4002       0.4040

1x128Mb (PC133, cycle length=2):
	    Copy:          85.8094       0.1865       0.1864       0.1870
2.2.14	    Scale:         84.3468       0.1897       0.1897       0.1898
	    Add:           91.5097       0.2623       0.2623       0.2623
	    Triad:         90.2346       0.2660       0.2660       0.2662

	    Copy:          85.8653       0.1864       0.1863       0.1866
2.4.0ac10   Scale:         84.4007       0.1897       0.1896       0.1898
	    Add:           91.6042       0.2621       0.2620       0.2623
	    Triad:         90.3296       0.2659       0.2657       0.2675

	    Copy:          88.4453       0.1817       0.1809       0.1840
2.4.1ac11   Scale:         86.4535       0.1856       0.1851       0.1874
	    Add:           93.0553       0.2583       0.2579       0.2599
	    Triad:         91.7694       0.2620       0.2615       0.2648

--------------78FE48C044846BF466EE274C--



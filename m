Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTIZS0e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 14:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbTIZS0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 14:26:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:11245 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261563AbTIZSZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 14:25:57 -0400
Message-Id: <200309261825.h8QIPq123031@mail.osdl.org>
Date: Fri, 26 Sep 2003 11:25:49 -0700 (PDT)
From: markw@osdl.org
Subject: Hackbench STP Results History Up To 2.6.0-test5-mm4
To: linux-kernel@vger.kernel.org, linstab@osdl.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hackbench (http://www.osdl.org/stp/test_details/hackbench-interp.html)
is a chat benchmark from Rusty Russel that's intended to test the
scalability of the scheduler.

The 'Metric' is the average time in seconds to do something with 100
processes.  Smaller numbers are better as well as a (-) change.  'Change' refers to a percentage change in the metric from the last
completed test with results.

I've shortened the list to the 2.6.0-test kernels this time.  The
2.6.0-test5-mm kernels look pretty consistent, and appear to offer a 1
second (~ 10%) improvement over the 2.6.0-test5 kernel for the 4- and
8-way systems.


1-way:
Kernel               Metric Change (%)  URL                                
-------------------- ------ ----------  ----------------------------------------
2.6.0-test4-mm2        15.4        N/A  http://khack.osdl.org/stp/280103/  
2.6.0-test4-mm4        15.8        3.0  http://khack.osdl.org/stp/280099/  
2.6.0-test4-mm5        16.3        2.7  http://khack.osdl.org/stp/280095/  
2.6.0-test4-mm6        15.3       -6.1  http://khack.osdl.org/stp/280091/  
linux-2.6.0-test5      15.5        1.4  http://khack.osdl.org/stp/280075/  
2.6.0-test5-mm2        15.3       -1.2  http://khack.osdl.org/stp/280087/  
2.6.0-test5-mm3        15.4        0.4  http://khack.osdl.org/stp/280374/  
2.6.0-test5-mm4        15.3       -0.6  http://khack.osdl.org/stp/280471/


2-way:
Kernel               Metric Change (%)  URL                                
-------------------- ------ ----------  ----------------------------------------
2.6.0-test4-mm2        11.7        N/A  http://khack.osdl.org/stp/280104/  
2.6.0-test4-mm4        11.7        0.0  http://khack.osdl.org/stp/280100/  
2.6.0-test4-mm5        12.5        6.6  http://khack.osdl.org/stp/280096/  
2.6.0-test4-mm6        11.8       -5.2  http://khack.osdl.org/stp/280092/  
linux-2.6.0-test5      11.9        0.4  http://khack.osdl.org/stp/280076/  
2.6.0-test5-mm2        11.8       -0.9  http://khack.osdl.org/stp/280088/  
2.6.0-test5-mm3        11.6       -1.2  http://khack.osdl.org/stp/280233/  
2.6.0-test5-mm4        11.6       -0.2  http://khack.osdl.org/stp/280360/


4-way:
Kernel               Metric Change (%)  URL                                
-------------------- ------ ----------  ----------------------------------------
2.6.0-test4-mm2         8.3        N/A  http://khack.osdl.org/stp/280105/  
2.6.0-test4-mm4         8.3       -0.8  http://khack.osdl.org/stp/280101/  
2.6.0-test4-mm5         8.6        4.6  http://khack.osdl.org/stp/280097/  
2.6.0-test4-mm6         8.3       -3.4  http://khack.osdl.org/stp/280093/  
linux-2.6.0-test5       9.4       12.1  http://khack.osdl.org/stp/280077/  
2.6.0-test5-mm2         8.4      -10.8  http://khack.osdl.org/stp/280089/  
2.6.0-test5-mm3         8.3       -0.2  http://khack.osdl.org/stp/280376/  
2.6.0-test5-mm4         8.3       -0.2  http://khack.osdl.org/stp/280375/


8-way:
Kernel               Metric Change (%)  URL                                
-------------------- ------ ----------  ----------------------------------------
2.6.0-test4-mm2         6.8        N/A  http://khack.osdl.org/stp/280106/  
2.6.0-test4-mm4         6.7       -0.2  http://khack.osdl.org/stp/280102/  
2.6.0-test4-mm6         6.8        1.3  http://khack.osdl.org/stp/280094/  
linux-2.6.0-test5       7.5        9.2  http://khack.osdl.org/stp/280078/  
2.6.0-test5-mm2         6.7       -9.8  http://khack.osdl.org/stp/280164/  
2.6.0-test5-mm3         6.7       -0.3  http://khack.osdl.org/stp/280378/  
2.6.0-test5-mm4         6.8        1.5  http://khack.osdl.org/stp/280377/

-- 
Mark Wong - - markw@osdl.org
Open Source Development Lab Inc - A non-profit corporation
12725 SW Millikan Way - Suite 400 - Beaverton, OR 97005
(503) 626-2455 x 32 (office)
(503) 626-2436      (fax)

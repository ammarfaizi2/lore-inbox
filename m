Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270560AbTGSWov (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 18:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270561AbTGSWov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 18:44:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26562 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270560AbTGSWoh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 18:44:37 -0400
Date: Sat, 19 Jul 2003 23:59:35 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: AMD Athlon MP Machine check exceptions
Message-ID: <20030719225935.GA628@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.0-test1 (i686)
X-Uptime: 23:55:45 up 6 min,  1 user,  load average: 0.02, 0.13, 0.08
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Is there any information on decoding AMD Athlon MP Machine
check exceptions?  I can't seem to find the appropriate AMD
document on their website - it would be nice to know
if this is RAM or cache or something else that gave it.

The error reported is:

Jul 19 21:07:37 gallifrey kernel: MCE: The hardware reports a non fatal,
correctable incident occurred on CPU 0.
Jul 19 21:07:37 gallifrey kernel: Bank 2: 940040000000017a

Thats from 2.5.75 on a dual Athlon MP on a Tyan 760MP motherboard.

The machine has apparently been running fine for some time now - perhaps
this is heat related due to the unusually warm weather over here,
or perhaps it is the machine check polling picking
up something that has been going dodgy for a while.

Dave
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278668AbRJSVnd>; Fri, 19 Oct 2001 17:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278666AbRJSVnX>; Fri, 19 Oct 2001 17:43:23 -0400
Received: from [194.213.32.137] ([194.213.32.137]:1284 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S278668AbRJSVnJ>;
	Fri, 19 Oct 2001 17:43:09 -0400
Message-ID: <20011019233246.A225@bug.ucw.cz>
Date: Fri, 19 Oct 2001 23:32:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.4.12: strange problem with time?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shomhz started reporting slower cpu to me... that made me curious. I
thought I have apm problem, but apparently something else is very
wrong:

pavel@bug:~$ date; time showmhz; date
Fri Oct 19 23:29:05 CEST 2001
96.996477 MHz processor.
0.00user 0.02system 2.84 (0m2.848s) elapsed 0.70%CPU
Fri Oct 19 23:29:06 CEST 2001
pavel@bug:~$

Ugh? 3 seconds elapsed while one second elapsed? Something is
wrong. This is toshiba4030cdt notebook. Anyone else experiencing this?
								Pavel
-- 
STOP THE WAR! Someone killed innocent Americans. That does not give
U.S. right to kill people in Afganistan.



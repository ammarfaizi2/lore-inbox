Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266377AbRG1FpT>; Sat, 28 Jul 2001 01:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266381AbRG1FpJ>; Sat, 28 Jul 2001 01:45:09 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:38065 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S266377AbRG1FpF>; Sat, 28 Jul 2001 01:45:05 -0400
Message-ID: <3B625147.E35216FF@yahoo.co.uk>
Date: Sat, 28 Jul 2001 01:44:39 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
Reply-To: jdthood_A@T_yahoo.co.uk
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Multiple apm resume events
In-Reply-To: <20010214092251.D1144@e-trend.de> <3A8AA725.7446DEA0@ubishops.ca> <20010214165758.L28359@e-trend.de> <20010214122244.H7859@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Machine:   ThinkPad 600
Kernel:    2.4.7-ac1

When I resume the machine the apmd_proxy script handles
*two* "resume suspend" events.  The apm driver ought to
filter multiple resume events.

About a year ago I had this and a couple other problems
with the apm driver.  I submitted patches to the maintainer,
Stephen Rothwell, but he was MIA.  "Too busy", he said.
I see he is still listed as the maintainer.  Is there 
someone else who is acting as the de facto maintainer or
should I just post patches to this list?

Thomas Hood
Please cc: jdthood_AT_yahoo.co.uk  with "_AT_" -> "@"

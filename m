Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265844AbSK3UNd>; Sat, 30 Nov 2002 15:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267049AbSK3UNc>; Sat, 30 Nov 2002 15:13:32 -0500
Received: from mta01ps.bigpond.com ([144.135.25.133]:47812 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S265844AbSK3UNc>; Sat, 30 Nov 2002 15:13:32 -0500
Message-ID: <3DE91CBF.295C1491@bigpond.net.au>
Date: Sun, 01 Dec 2002 06:17:03 +1000
From: Chris Ison <cisos@bigpond.net.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20-rc2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel space access to user space functions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I realize I asked this previously, but the answer given was not to the
question I asked.

How can I get a kernel module to call a function within a program?

The reason being I am creating a software midi driver and already have a
small program that does what I want the driver to do, problem is all the
math in the program is floating point.

What I would like to do, is be able to run the program, and have the
kernel software midi driver call a function within the program to que up
midi events, and have the program do all the hard work of the wavetable
synth.

This way, any improvements to the software don't have to be translated
to the driver, and visa versa.

How can I make this happen. And please give an example.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264835AbTGBImH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 04:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264839AbTGBImH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 04:42:07 -0400
Received: from web11803.mail.yahoo.com ([216.136.172.157]:57479 "HELO
	web11803.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264835AbTGBImG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 04:42:06 -0400
Message-ID: <20030702085630.55048.qmail@web11803.mail.yahoo.com>
Date: Wed, 2 Jul 2003 10:56:30 +0200 (CEST)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: Re: [PATCH] BadRAM for 2.5.73-mm2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Nowdays the biggest problem seems to be slightly incompatible timings
 in between motherboard and physical RAM that hurts the most, not so
 much non-working bits in RAM devices.
 Is there someone who has a patch so that, in case of a kernel OOPS
 (or maybe SIGSEGV / SIGILL outside kernel) is checking at least
 the code page where IP register points to check if a bit has flipped?
 Could be done by checking the page on the Hard Disk or by a CRC method.
 Having a bad BIOS parameter so that _one_ bit changes randomly every
 hours is not an easy thing to detect - a message on the screen would
 be nice...

  Etienne.

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com

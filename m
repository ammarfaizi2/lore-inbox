Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263029AbTDYF3m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 01:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbTDYF3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 01:29:42 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:34833 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S263029AbTDYF3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 01:29:39 -0400
Date: Fri, 25 Apr 2003 07:41:19 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: softdog.c doesn't compile in 2.5.68-bk5
Message-ID: <20030425054119.GA3034@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/watchdog/softdog.c doesn't compile in 2.5.68-bk5.

struct inode isn't defined, so it needs an #include <linux/fs.h> at the
top.

HTH,
Jurriaan
-- 
Midnight Oil, cyber troubadours, busking in a hall near you. When the
economy dries up, you'll find us on the back of a flatback truck
playing for cans of food.
        Peter Garett, Midnight Oil
Debian (Unstable) GNU/Linux 2.5.68 3940 bogomips 4 users load av: 1.33 0.69 0.45

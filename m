Return-Path: <linux-kernel-owner+w=401wt.eu-S1754239AbWL3Lma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbWL3Lma (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 06:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754353AbWL3Lma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 06:42:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49446 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239AbWL3Lm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 06:42:29 -0500
Subject: Re: Want comments regarding patch
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Bodo Eggert <7eggert@gmx.de>,
       Daniel =?ISO-8859-1?Q?Marjam=E4ki?= <daniel.marjamaki@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0612301206090.26556@yvahk01.tjqt.qr>
References: <7x8ul-7NU-7@gated-at.bofh.it> <7x8E5-80F-13@gated-at.bofh.it>
	 <7xdkq-7tB-25@gated-at.bofh.it> <7xjSQ-1fR-13@gated-at.bofh.it>
	 <7xn0j-6rY-7@gated-at.bofh.it> <E1H0Rec-00011Y-55@be1.lrz>
	 <Pine.LNX.4.61.0612301206090.26556@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 30 Dec 2006 12:42:24 +0100
Message-Id: <1167478945.20929.442.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yeah I don't do assembler soo often that I would know everything from heart.
> All your comments are valid of course. I just wanted to point out the idea.
> (However, if it's not repz, then it's repnz! :-)

it's better to use a gcc builtin than handcoding the asm yourself;
better for performance at least....
(gcc will pick the best code for the cpu you picked, and yes this
changes every generation or so)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org


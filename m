Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVB1OnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVB1OnJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVB1OnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:43:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10928 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261205AbVB1OnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 09:43:04 -0500
Date: Mon, 28 Feb 2005 15:43:06 +0100
From: Martin Mares <mj@ucw.cz>
To: colbuse@ensisun.imag.fr
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/2] drivers/char/vt.c: remove unnecessary code
Message-ID: <20050228144306.GA16596@atrey.karlin.mff.cuni.cz>
References: <1109596437.422319158044b@webmail.imag.fr> <20050228132849.B16460@flint.arm.linux.org.uk> <1109599275.4223242b6b560@webmail.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109599275.4223242b6b560@webmail.imag.fr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I agree :) . But, if we look to the code, we can notice that there is actually
> no reason for npar to be unsigned. What do you think of this version?

What does it try to solve?  Your version is in no way better than the previous one.
The previous one was more readable and it's quite possible that both
will be compiled to the same sequence of instructions.

Also, as Arjan noted, if you want to improve the code, use memset.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
American patent law: two monkeys, fourteen days.

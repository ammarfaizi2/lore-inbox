Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbVIQMBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbVIQMBX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 08:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbVIQMBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 08:01:23 -0400
Received: from albireo.ucw.cz ([84.242.65.108]:10175 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S1751084AbVIQMBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 08:01:23 -0400
Date: Sat, 17 Sep 2005 14:01:23 +0200
From: Martin Mares <mj@ucw.cz>
To: =?iso-8859-2?B?Ik1hcnRpbiB2LiBM9ndpcyI=?= <martin@v.loewis.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
Message-ID: <20050917120123.GA3095@ucw.cz>
References: <4NsP0-3YF-13@gated-at.bofh.it> <4NsP0-3YF-15@gated-at.bofh.it> <4NsP0-3YF-17@gated-at.bofh.it> <4NsP1-3YF-19@gated-at.bofh.it> <4NsP1-3YF-21@gated-at.bofh.it> <4NsOZ-3YF-9@gated-at.bofh.it> <4NsYH-4bv-27@gated-at.bofh.it> <4NtBr-4WU-3@gated-at.bofh.it> <4NtL0-5lQ-13@gated-at.bofh.it> <432B2C49.8080008@v.loewis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432B2C49.8080008@v.loewis.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> This is true for text files, where a human reader can interpret the data
> correctly even in absence of a declaration. For programming languages,
> this is typically not the case. Instead, in order to correctly interpret
> the source code, you need to declare the encoding. For a script,
[...]

This makes no sense. For a script, the shell does not care about the encoding
at all.

Also, currently, people use zillions of encodings, most of which have no
signature, so introducing a signature for UTF-8 does not win anything.

In the future, most people will probably use only UTF-8, so the signature
carries no information.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Q: Who invented the first airplane that did not fly?  A: The Wrong Brothers.

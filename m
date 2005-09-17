Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbVIQNFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVIQNFa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 09:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVIQNFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 09:05:30 -0400
Received: from albireo.ucw.cz ([84.242.65.108]:14477 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S1751103AbVIQNF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 09:05:29 -0400
Date: Sat, 17 Sep 2005 15:05:29 +0200
From: Martin Mares <mj@ucw.cz>
To: =?iso-8859-2?B?Ik1hcnRpbiB2LiBM9ndpcyI=?= <martin@v.loewis.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
Message-ID: <20050917130529.GA4398@ucw.cz>
References: <4NsP1-3YF-21@gated-at.bofh.it> <4NsOZ-3YF-9@gated-at.bofh.it> <4NsYH-4bv-27@gated-at.bofh.it> <4NtBr-4WU-3@gated-at.bofh.it> <4NtL0-5lQ-13@gated-at.bofh.it> <432B2C49.8080008@v.loewis.de> <20050917120123.GA3095@ucw.cz> <432C0B51.704@v.loewis.de> <20050917122828.GA4103@ucw.cz> <432C11B3.8080302@v.loewis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432C11B3.8080302@v.loewis.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> With the UTF-8 signature, things become much simpler: editors can
> automatically detect presence of the signature, and need no
> language-specific parsing.

I still think that this does solve only a completely insignificant part
of the problem. Given the zillion existing encodings, you are able to identify
UTF-8, leaving you with zillion-1 other encodings you are unable to deal with.

> Probably not literally, as we are not searching for an explanation of
> some phenomenon.

ACK, not literally.

> You are probably suggesting that people dislike the
> feature because they see no need for it (as one poster stated it:
> I don't use UTF-8, so I don't want that feature).

I see a need for a feature which would help identify the charset of the script,
but the patch in question obviously doesn't offer that -- it solves only a single
special case of the problem in a completely non-systematic way. This does not
sound right.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"How I need a drink, alcoholic in nature, after the tough chapters involving quantum mechanics!" = \pi

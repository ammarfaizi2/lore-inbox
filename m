Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbTGBT1k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 15:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264469AbTGBT1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 15:27:40 -0400
Received: from hera.cwi.nl ([192.16.191.8]:34455 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264463AbTGBT1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 15:27:39 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 2 Jul 2003 21:42:01 +0200 (MEST)
Message-Id: <UTC200307021942.h62Jg1L20419.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, akpm@digeo.com
Subject: Re: [PATCH] cryptoloop
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* akpm> Where are the first and second patches btw?  Merged?  Is a fourth
* akpm> anticipated?)

Yes, merged.

(Usually I plan a track and submit individual steps.
When they get applied I continue.
If not, there is not need to waste time on the rest.)

Here a series of about half a dozen steps was announced.


* akpm> Splitting these changes into two almost doubles the testing effort,

One should always go in many small steps.
Each step so that it is clear what happens.
Preferably with different steps separated by a kernel release,
so that if things break, people can tell at what kernel version.


* akpm> Could we pleeeze have a little cryptoloop.txt which just gives
* akpm> the basics on where to obtain the tools and how to get the thing
* akpm> up and running?  It's a right pain having to go scrabbling
* akpm> all over the internet working out how to set stuff up
* akpm> if you just want to do a bit of testing every few months.

Please read the help message in the config menu.
Then read the text accompanying my patch.
When still needed, read losetup(8).

Andries



[Let me say the same things in different words. You want to test.
I think you are too early, since I have not released util-linux 2.12,
and will wait until this, or a similar, patch has been applied.
You can test that no old things are broken by using mount (-o loop)
or losetup. If you are really very eager I can prepare a tar file
for you and put it on some ftp site.]


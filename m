Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266888AbUI0SKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266888AbUI0SKW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 14:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266884AbUI0SKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 14:10:22 -0400
Received: from dslsmtp.struer.net ([62.242.36.21]:15113 "EHLO
	dslsmtp.struer.net") by vger.kernel.org with ESMTP id S261232AbUI0SKP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 14:10:15 -0400
Message-ID: <62980.194.237.142.13.1096308614.squirrel@194.237.142.13>
In-Reply-To: <20040927113727.GQ16153@parcelfarce.linux.theplanet.co.uk>
References: <20040917170051.GU642@parcelfarce.linux.theplanet.co.uk>
    <20040927072246.GA8613@mars.ravnborg.org>
    <20040927113727.GQ16153@parcelfarce.linux.theplanet.co.uk>
Date: Mon, 27 Sep 2004 20:10:14 +0200 (CEST)
Subject: Re: [PATCH] make make install install modules too
From: "Sam Ravnborg" <sam@ravnborg.org>
To: "Matthew Wilcox" <matthew@wil.cx>
Cc: "Matthew Wilcox" <willy@debian.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@zip.com.au>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> No, we do not want to change such basic behaviour.
>> So many poeple are used to current scheme with:
>> make modules_install && make install
>>
>> that it would't be worth breaking their ways of working.
>
> Ehm, this wouldn't _break_ them.  They'd just end up installing modules
> twice.
Broken in the sense that it does more than expected.

   Sam



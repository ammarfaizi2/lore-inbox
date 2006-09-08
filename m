Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWIHQ4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWIHQ4S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 12:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWIHQ4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 12:56:17 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:23190 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750721AbWIHQ4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 12:56:16 -0400
Date: Fri, 8 Sep 2006 18:55:10 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] proc: Make the generation of the self symlink table
 driven.
In-Reply-To: <m1fyf2lc91.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.61.0609081851260.19699@yvahk01.tjqt.qr>
References: <m1odttx8uz.fsf@ebiederm.dsl.xmission.com> <20060907101512.3e3a9604.akpm@osdl.org>
 <Pine.LNX.4.61.0609080906380.22545@yvahk01.tjqt.qr> <m11wqmmxfw.fsf@ebiederm.dsl.xmission.com>
 <Pine.LNX.4.61.0609081507330.20566@yvahk01.tjqt.qr> <m1fyf2lc91.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Regardless this isn't a case where the C precedence is wrong.
>"a < b | 1" is an example of C getting the precedence wrong.

Blame the creator of C.
But maybe this was intended, since | is a logical operation, as is <, 
while + is an arithmetic one. Programmatically probably not making much 
sense, bitfield |= a < b is one use case.

>Having to remember where C is wrong and in what circumstances is
>harder than just putting in parenthesis.

The GNU C compiler will warn you where such may happen, but
currently does so - too bad - only with && and ||.
 c.c:2: warning: suggest parentheses around && within ||


Jan Engelhardt
-- 

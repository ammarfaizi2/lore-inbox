Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWIHNJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWIHNJu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 09:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWIHNJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 09:09:49 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:5540 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751079AbWIHNJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 09:09:49 -0400
Date: Fri, 8 Sep 2006 15:08:48 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] proc: Make the generation of the self symlink table
 driven.
In-Reply-To: <m11wqmmxfw.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.61.0609081507330.20566@yvahk01.tjqt.qr>
References: <m1odttx8uz.fsf@ebiederm.dsl.xmission.com> <20060907101512.3e3a9604.akpm@osdl.org>
 <Pine.LNX.4.61.0609080906380.22545@yvahk01.tjqt.qr> <m11wqmmxfw.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> +	for (; nr < (ARRAY_SIZE(proc_base_stuff) - 1); filp->f_pos++, nr++) {
>>>
>> Also works without the () around ARRAY_SIZE(..)-1
>
>Sure.  But I don't really trust C precedence (because it is wrong)

Wrong? In mathematics, "a < (b - 1)" also is equivalent to "a < b - 1".

>and having to remember where it is wrong sucks.  Plus in this
>case I really am making it clear that ARRAY_SIZE(..)-1 is the concept
>I want.   If there would any more to the expression that would
>be important.


Jan Engelhardt
-- 

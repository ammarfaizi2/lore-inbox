Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968658AbWLEUay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968658AbWLEUay (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968669AbWLEUay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:30:54 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:37274 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968658AbWLEUax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:30:53 -0500
Date: Tue, 5 Dec 2006 21:30:01 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jaswinder Singh <jaswinderrajput@gmail.com>
cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, linux-kernel@vger.kernel.org
Subject: Re: PREEMPT is messing with everyone
In-Reply-To: <aa5953d60612050850v240b382fm172702b1d28934a1@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0612052129380.18570@yvahk01.tjqt.qr>
References: <aa5953d60612050610l1f2657c3ie073467a2b2a7126@mail.gmail.com> 
 <45758B57.6040107@stud.feec.vutbr.cz> <aa5953d60612050850v240b382fm172702b1d28934a1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes, Compiler will remove it but this looks ugly and confusing.
>
> Why dont we use like this :-

Even more fugly.

> # ifdef CONFIG_PREEMPT
> # include <linux/preempt.h>
> # endif
>
> #ifdef CONFIG_PREEMPT
> preempt_disable();
> #endif
>
> #ifdef CONFIG_PREEMPT
> preempt_enable();
> #endif
>

	-`J'
-- 

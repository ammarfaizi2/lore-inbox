Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317563AbSFRTOZ>; Tue, 18 Jun 2002 15:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317565AbSFRTN1>; Tue, 18 Jun 2002 15:13:27 -0400
Received: from mail.webmaster.com ([216.152.64.131]:45199 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317562AbSFRTMe> convert rfc822-to-8bit; Tue, 18 Jun 2002 15:12:34 -0400
From: David Schwartz <davids@webmaster.com>
To: <rusty@rustcorp.com.au>
CC: <mgix@mgix.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Tue, 18 Jun 2002 12:12:30 -0700
In-Reply-To: <20020619045606.3566a8cc.rusty@rustcorp.com.au>
Subject: Re: Question about sched_yield()
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020618191233.AAA27954@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jun 2002 04:56:06 +1000, Rusty Russell wrote:

>On Mon, 17 Jun 2002 17:46:29 -0700
>David Schwartz <davids@webmaster.com> wrote:

>>"The sched_yield() function shall force the running thread to relinquish
>>the
>>processor until it again becomes the head of its thread list. It takes no
>>arguments."

>Notice how incredibly useless this definition is.  It's even defined in 
>terms
>of UP.

	Huh?! This definition is beautiful in that it makes no such assumptions. How 
would you say this is invalid on an SMP machine? By "the processor", they 
mean "the process on which the thread is running" (the only one it could 
relinquish, after all).

	DS



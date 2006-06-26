Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWFZUg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWFZUg0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWFZUg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:36:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16286 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932070AbWFZUgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:36:25 -0400
Date: Mon, 26 Jun 2006 13:36:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: oom-killer problem
In-Reply-To: <6bffcb0e0606261306i7f5a3326oa0c7f53aac2aa18d@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0606261335230.3927@g5.osdl.org>
References: <6bffcb0e0606261306i7f5a3326oa0c7f53aac2aa18d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Jun 2006, Michal Piotrowski wrote:
> 
> I have noticed a small problem with
> 2.6.17-5fd571cbc13db113bda26c20673e1ec54bfd26b4 - in fact, it doesn't
> work.

Well, it looks to me like you have IDE problems (and shaky hands ;)

Can you pinpoint when these things started happening? "git bisect" is your 
friend..

		Linus

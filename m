Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277082AbRJHSto>; Mon, 8 Oct 2001 14:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277074AbRJHStZ>; Mon, 8 Oct 2001 14:49:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13065 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277073AbRJHStI>; Mon, 8 Oct 2001 14:49:08 -0400
Date: Mon, 8 Oct 2001 11:48:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Bob Miller <bob.miller@znyx.com>
cc: <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>, <jamal.hadi@znyx.com>
Subject: Re: Possible change to ./scripts/split-include.c
In-Reply-To: <3BC1CEB5.8060703@znyx.com>
Message-ID: <Pine.LNX.4.33.0110081146450.8212-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Oct 2001, Bob Miller wrote:
>
> If this change is reasonable, could you consider merging it into future
> kernels.  Attached is a diff -u for the change to split-include.c

Looks reasonable to me - the only non-*.h files I find in the include
directory seems to be automatically generated with no config information.

		Linus


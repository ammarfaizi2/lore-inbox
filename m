Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbSKVGN3>; Fri, 22 Nov 2002 01:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265777AbSKVGN3>; Fri, 22 Nov 2002 01:13:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22106 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265532AbSKVGN2>; Fri, 22 Nov 2002 01:13:28 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] export e820 table on x86
References: <Pine.LNX.4.44.0211211556340.5779-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Nov 2002 23:20:01 -0700
In-Reply-To: <Pine.LNX.4.44.0211211556340.5779-100000@penguin.transmeta.com>
Message-ID: <m1bs4iyvla.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:
> 
> In other words, I would suggest you fix that 64-bit issue, remove the
> artificial limiting in setup.c, extend the "case" statement to cover any
> cases you're interested in, and test it on something with >4GB of memory
> to see that it works, and I'll be more than happy to take it.

Sounds like a plan.  If Dave doesn't get to it I will take a look, at
it.  It's a nice clean way of getting the information out of the
kernel, and it is already there.

Eric


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318107AbSICQvz>; Tue, 3 Sep 2002 12:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318814AbSICQvz>; Tue, 3 Sep 2002 12:51:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17419 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318107AbSICQvy>; Tue, 3 Sep 2002 12:51:54 -0400
Date: Tue, 3 Sep 2002 01:45:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Nikita Danilov <Nikita@Namesys.COM>
cc: linux-kernel@vger.kernel.org
Subject: Re: Large block device patch, part 1 of 9
In-Reply-To: <15732.59029.941417.550708@laputa.namesys.com>
Message-ID: <Pine.LNX.4.44.0209030135270.12861-100000@kiwi.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Sep 2002, Nikita Danilov wrote:
>
> See <printf.h>: register_printf_function(). -Wformat doesn't know about
> new specifiers, though.

That's just an internal way to add ways to print out different numbers to
the libc version of printf - it doesn't actually tell _gcc_ what the
modifiers are.

		Linus


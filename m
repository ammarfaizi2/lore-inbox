Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265933AbRFZHmD>; Tue, 26 Jun 2001 03:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265934AbRFZHlx>; Tue, 26 Jun 2001 03:41:53 -0400
Received: from zeus.kernel.org ([209.10.41.242]:19902 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S265933AbRFZHlh>;
	Tue, 26 Jun 2001 03:41:37 -0400
Date: Tue, 26 Jun 2001 09:40:16 +0200
From: Thomas Pornin <Thomas.Pornin@ens.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: GCC3.0 Produce REALLY slower code!
Message-ID: <20010626094016.A5899@bolet.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200106260121.f5Q1LuE14141@habitrail.home.fools-errant.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200106260121.f5Q1LuE14141@habitrail.home.fools-errant.com>
you write:
> Then there's the other question: Why should we test a compiler that
> seems to be quite proprietary?

Apart from questions of optimization, compiling the same code with two
different compilers is a very good way to find bugs, both in the code
and in the compilers.

Besides, the kernel is, for now, dependent on many gcc features; but
it might be worth thinking about writing code a bit more "standard",
just in case another free C compiler emerges on some specific arch. Then
again, aiming at compiling with several compilers is one way to achieve
portability.

(yet I do not believe it will happen anyday soon)


	--Thomas Pornin

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318132AbSHBE1Z>; Fri, 2 Aug 2002 00:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318149AbSHBE1X>; Fri, 2 Aug 2002 00:27:23 -0400
Received: from holomorphy.com ([66.224.33.161]:18623 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318132AbSHBE1V>;
	Fri, 2 Aug 2002 00:27:21 -0400
Date: Thu, 1 Aug 2002 21:30:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: large page patch
Message-ID: <20020802043029.GH25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <3D49D45A.D68CCFB4@zip.com.au> <737220000.1028250590@flay> <aid0he$1h4$1@penguin.transmeta.com> <20020801.211357.93822733.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020801.211357.93822733.davem@redhat.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 2 Aug 2002 04:07:10 +0000 (UTC)
>    Of course, if you can actually measure it, that would be
>    interesting.  Naive math gives you a guess for the order of
>    magnitude effect, but nothing beats real numbers ;)

On Thu, Aug 01, 2002 at 09:13:57PM -0700, David S. Miller wrote:
> The SYSV folks actually did have a buddy allocator a long time ago and
> they did implement lazy coalescing because is supposedly improved
> performance.
> See chapter 12 section 7 in "Unix Internals" by Uresh Vahalia.

And I've implemented it for Linux.

ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/lazy_buddy/


Cheers,
Bill

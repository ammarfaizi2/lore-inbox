Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271762AbRHURrj>; Tue, 21 Aug 2001 13:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271764AbRHURrV>; Tue, 21 Aug 2001 13:47:21 -0400
Received: from are.twiddle.net ([64.81.246.98]:64424 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S271762AbRHURq7>;
	Tue, 21 Aug 2001 13:46:59 -0400
Date: Tue, 21 Aug 2001 10:47:04 -0700
From: Richard Henderson <rth@twiddle.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] /proc/ksyms change for IA64
Message-ID: <20010821104704.A6190@twiddle.net>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010818182756.A29533@twiddle.net> <31011.998376800@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <31011.998376800@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Tue, Aug 21, 2001 at 04:53:20PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2001 at 04:53:20PM +1000, Keith Owens wrote:
> ... but why bother when bfd already does it for me?

How about bfd is a bloated monstrosity.  Right now libobj is
just over 10k; you'll be looking at a _minimum_ of 150k to
pull in only the linking code from libbfd.a.

How about bfd is an unmaintainable nightmare?  If you've not
spent the last couple of years working on bfd, save your
sanity and don't start.

It would take only a day or three to fix up libobj to cross
compile.  If you don't want to do it, let someone else.


r~

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277807AbRJIQLB>; Tue, 9 Oct 2001 12:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277808AbRJIQKw>; Tue, 9 Oct 2001 12:10:52 -0400
Received: from are.twiddle.net ([64.81.246.98]:7077 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S277807AbRJIQKf>;
	Tue, 9 Oct 2001 12:10:35 -0400
Date: Tue, 9 Oct 2001 09:11:01 -0700
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: pmckenne@us.ibm.com, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011009091101.A27319@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	pmckenne@us.ibm.com, lse-tech@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <200110090155.f991tPt22329@eng4.beaverton.ibm.com> <20011008235208.A26109@twiddle.net> <20011009190337.0009802c.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011009190337.0009802c.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Tue, Oct 09, 2001 at 07:03:37PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 07:03:37PM +1000, Rusty Russell wrote:
> I don't *like* making Alpha's wmb() stronger, but it is the
> only solution which doesn't touch common code.

It's not a "solution" at all.  It's so heavy weight you'd be
much better off with locks.  Just use the damned rmb_me_harder.


r~

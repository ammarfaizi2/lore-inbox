Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310362AbSCGP15>; Thu, 7 Mar 2002 10:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310359AbSCGP1r>; Thu, 7 Mar 2002 10:27:47 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:11452 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S310363AbSCGP1g>; Thu, 7 Mar 2002 10:27:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: furwocks: Fast Userspace Read/Write Locks
Date: Thu, 7 Mar 2002 10:28:34 -0500
X-Mailer: KMail [version 1.3.1]
Cc: lse-tech@lists.sourceforge.net
In-Reply-To: <E16iwkE-000216-00@wagner.rustcorp.com.au>
In-Reply-To: <E16iwkE-000216-00@wagner.rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020307152730.2BD483FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 March 2002 07:11 am, Rusty Russell wrote:
> This is a userspace implementation of rwlocks on top of futexes.
>
> Release was delayed because tdbtorture started crashing... turns out
> it's unrelated 2.5.6-pre2 wierdness (after a good 6 hours debugging
> <SIGH>).
>
> So I don't have numbers, but I'm pretty sure this is as good as it
> gets without explicit kernel support for rwlocks.  Kudos to Paul
> Mackerras for the brainwork on this one.  Blame me for the name.
>
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/futex-1.2.tar.gz
>
> Cheers!
> Rusty.

I'll integrate these into the ulockflex and see what the numbers are
and whether the implementation is correct.


-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)

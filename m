Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264230AbRFMVOB>; Wed, 13 Jun 2001 17:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264238AbRFMVNv>; Wed, 13 Jun 2001 17:13:51 -0400
Received: from atlrel2.hp.com ([156.153.255.202]:51398 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S264230AbRFMVNm>;
	Wed, 13 Jun 2001 17:13:42 -0400
Message-ID: <3B27D7A2.854DF5D1@fc.hp.com>
Date: Wed, 13 Jun 2001 15:14:10 -0600
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Mokryn <mark@sangate.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP module compilation on UP?
In-Reply-To: <3B276DDE.A19F60DF@sangate.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mokryn wrote:
> 
> Hi,
> 
> Is it possible to build an SMP module on a machine running a UP kernel
> (or vice versa)? We of course get unresolved symbols during module load
> due to the smp prefix on the ksyms, and haven't seen how to get around
> it. (Defining __SMP__ does not cut it, though I believe this used to
> work a while ago).
> 

Why not just run an SMP kernel on UP machine? Yes, there may be minor
performance penalty but that may be irrelevant for you if it lets you
build and load SMP modules on that machine. With a UP kernel running,
you will be able to build SMP modules but not load them.

-- 
Khalid

====================================================================
Khalid Aziz                             Linux Development Laboratory
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO

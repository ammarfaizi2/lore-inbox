Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275743AbRJJNhI>; Wed, 10 Oct 2001 09:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275750AbRJJNg6>; Wed, 10 Oct 2001 09:36:58 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:36872 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S275734AbRJJNgn>; Wed, 10 Oct 2001 09:36:43 -0400
Date: Wed, 10 Oct 2001 15:36:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: safemode <safemode@speakeasy.net>
Cc: Andrew Morton <akpm@zip.com.au>,
        Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Message-ID: <20011010153653.Q726@athlon.random>
In-Reply-To: <200110100358.NAA17519@isis.its.uow.edu.au> <20011010072607.P726@athlon.random> <20011010114132Z275506-760+23131@vger.kernel.org> <20011010120009.851921E7C9@Cantor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011010120009.851921E7C9@Cantor.suse.de>; from safemode@speakeasy.net on Wed, Oct 10, 2001 at 08:00:04AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 08:00:04AM -0400, safemode wrote:
> OK, i copied the mp3 into /dev/shm and without any renicing of anything it 
> plays fine during dbench 32.  so the problem is disk access taking too long.  
> 
> Which is strange since i'm running dbench on a separate hdd on a totally 
> different controller. 

then if you know it's not disk congestion, it's most probably due the vm
write throttling.

Andrea

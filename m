Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263992AbRFNTT3>; Thu, 14 Jun 2001 15:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263989AbRFNTTT>; Thu, 14 Jun 2001 15:19:19 -0400
Received: from be02.imake.com ([151.200.87.11]:14094 "EHLO be02.tfsm.com")
	by vger.kernel.org with ESMTP id <S263986AbRFNTTM>;
	Thu, 14 Jun 2001 15:19:12 -0400
Message-ID: <3B290EFB.B0BC77D0@247media.com>
Date: Thu, 14 Jun 2001 15:22:36 -0400
From: Russell Leighton <russell.leighton@247media.com>
X-Mailer: Mozilla 4.51 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: threading question
In-Reply-To: <Pine.GSO.4.10.10106121200330.20809-100000@orbit-fe.eng.netapp.com> <E15Abr6-00057R-00@the-village.bc.nu> <20010614210138.A15912@home.ds9a.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bert hubert wrote:

> <stuff deleted>
>
> I see lots of people only using:
>         pthread_create()/pthread_join()
>         mutex_lock/unlock
>         sem_post/sem_wait
>         no signals
>
> My gut feeling is that you could implement this subset in a way that is both
> fast and right - although it would not be 'pthreads compliant'. Can anybody
> confirm this feeling?

... add condition variables (maybe a small per-thread storage area)
and I'd toss out pthreads for most apps I write...especially if it is very efficient.

--
---------------------------------------------------
Russell Leighton    russell.leighton@247media.com
---------------------------------------------------



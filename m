Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264869AbRF3JQz>; Sat, 30 Jun 2001 05:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264874AbRF3JQp>; Sat, 30 Jun 2001 05:16:45 -0400
Received: from vagabond.btnet.cz ([62.80.85.77]:8832 "EHLO vagabond.btnet.cz")
	by vger.kernel.org with ESMTP id <S264869AbRF3JQa>;
	Sat, 30 Jun 2001 05:16:30 -0400
Date: Sat, 30 Jun 2001 11:16:17 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Message-ID: <20010630110907.A898@vagabond>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> I am happy that processes in Linux are so marvelous. Linux does not need
> a decent POSIX threads implementation because the same functionality can
> be achived with processes. Do what you like, you write the kernel code.
> I could write my soft using fork special fetaures in Linux.
> But I want it to be portable. If threads in linux are so bad, it is bad
> luck for me. I will go slow. It its the only portable way todo afordable
> shared memory threading without filling your program of shm-xxxx.

AFAIK, there is a POSIX thread library (libpthread) for Linux, that wraps
clone calls in a way portable to other unices. It uses processes (with memory
sharing) from kernel point of view, but should look like POSIX threads from
application point of view.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

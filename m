Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbRFXCtr>; Sat, 23 Jun 2001 22:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265715AbRFXCth>; Sat, 23 Jun 2001 22:49:37 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:57102 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S265712AbRFXCt1>;
	Sat, 23 Jun 2001 22:49:27 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106240249.f5O2nIF07215@saturn.cs.uml.edu>
Subject: Re: Shared memory quantity not being reflected by /proc/meminfo
To: allan.d@bigpond.com (Allan Duncan)
Date: Sat, 23 Jun 2001 22:49:18 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B3486C7.7A39478@bigpond.com> from "Allan Duncan" at Jun 23, 2001 10:08:39 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allan Duncan writes:

> Since the 2.4.x advent of shm as tmpfs or thereabouts,
> /proc/meminfo shows shared memory as 0.  It is in
> reality not zero, and is being allocated, and shows
> up in /proc/sysvipc/shm and /proc/sys/kernel/shmall
> etc..
> Neither 2.4.6-pre5 nor 2.4.5-ac17 have the correct
> display.

You misunderstood what 2.2.xx kernels were reporting.
The "shared" memory in /proc/meminfo refers to something
completely unrelated to SysV shared memory. This is no
longer calculated because the computation was too costly.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318066AbSFSX5C>; Wed, 19 Jun 2002 19:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318067AbSFSX5B>; Wed, 19 Jun 2002 19:57:01 -0400
Received: from holomorphy.com ([66.224.33.161]:14268 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318066AbSFSX5B>;
	Wed, 19 Jun 2002 19:57:01 -0400
Date: Wed, 19 Jun 2002 16:56:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] scheduler bits from 2.5.23-dj1
Message-ID: <20020619235632.GQ22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Linus Torvalds <torvalds@transmeta.com>
References: <20020619112308.GA11631@suse.de> <Pine.LNX.4.44.0206200123470.25434-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206200123470.25434-100000@e2>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 01:36:29AM +0200, Ingo Molnar wrote:
> another change in 2.5.23-dj1 is the initialization of the pidhash in
> sched_init(). It does not belong there - please create a new init function
> within fork.c if needed. The pidhash init used to be in sched_init(), but
> this doesnt make it right.

On its way shortly.


Cheers,
Bill

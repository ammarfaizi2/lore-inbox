Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266849AbSIRO6O>; Wed, 18 Sep 2002 10:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266894AbSIRO6O>; Wed, 18 Sep 2002 10:58:14 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:47063 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S266849AbSIRO6N>;
	Wed, 18 Sep 2002 10:58:13 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 18 Sep 2002 09:01:05 -0600
To: William Lee Irwin III <wli@holomorphy.com>,
       Andries Brouwer <aebr@win.tue.nl>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918090104.E14918@host110.fsmlabs.com>
References: <Pine.LNX.4.44.0209180024090.30913-100000@localhost.localdomain> <20020918123206.GA14595@win.tue.nl> <20020918144939.GU3530@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020918144939.GU3530@holomorphy.com>; from wli@holomorphy.com on Wed, Sep 18, 2002 at 07:49:39AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can we get a lockless, scalable, fault-tolerant, pre-emption safe,
zero-copy and distributed get_pid() that meets the Carrier Grade
specification?  If at all possible I need it to do garbage collection, too.

Perhaps a get_pid() that solves the Turning Halting Problem should be on
the todo list for 2.6.

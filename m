Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269666AbSIRSdH>; Wed, 18 Sep 2002 14:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269677AbSIRSdH>; Wed, 18 Sep 2002 14:33:07 -0400
Received: from holomorphy.com ([66.224.33.161]:57579 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S269666AbSIRSdG>;
	Wed, 18 Sep 2002 14:33:06 -0400
Date: Wed, 18 Sep 2002 11:32:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918183250.GZ3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andries Brouwer <aebr@win.tue.nl>, Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209180024090.30913-100000@localhost.localdomain> <20020918123206.GA14595@win.tue.nl> <20020918144939.GU3530@holomorphy.com> <20020918183154.GB14629@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020918183154.GB14629@win.tue.nl>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 07:49:39AM -0700, William Lee Irwin III wrote:
>> Basically, the nondeterministic behavior of these things is NMI oopsing
>> my machines and those of users (who often just cut the power instead of
>> running the NMI oopser). get_pid() is actually not the primary offender,
>> but is known to be problematic along with the rest of them.

On Wed, Sep 18, 2002 at 08:31:54PM +0200, Andries Brouwer wrote:
> Sorry - I cannot parse this. Who are "these things" and "them"?

Functions exhaustively searching or otherwise iterating over the whole
list of all tasks.


Bill

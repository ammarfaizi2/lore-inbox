Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSDSG5X>; Fri, 19 Apr 2002 02:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311834AbSDSG5W>; Fri, 19 Apr 2002 02:57:22 -0400
Received: from holomorphy.com ([66.224.33.161]:53152 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S311752AbSDSG5W>;
	Fri, 19 Apr 2002 02:57:22 -0400
Date: Thu, 18 Apr 2002 23:56:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] migration thread fix
Message-ID: <20020419065632.GD21206@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20020419064851.GC21206@holomorphy.com> <Pine.LNX.4.44.0204190646380.4350-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2002, William Lee Irwin III wrote:
>> I've got a few of those around, I'll see if I can reproduce it. How many
>> cpu's did you need to bring it out?

On Fri, Apr 19, 2002 at 06:48:45AM +0200, Ingo Molnar wrote:
> 2 physical - but i'd suggest to test Erich's patch instead. I had
> debugging code in the scheduler which did printks, which slowed down some
> of the operations in question, such as the startup of the idle thread -
> which created weird situations. [which might not occur in normal testing,
> but which are possible nevertheless.]

That's not many. I'll try it on a bigger one, with a few big fat printk's
in idle task startup and see if I can bring it down. It's an interesting
little tidbit of programming.

As I said earlier, Erich's patch already passed my testing. Thanks though.


Cheers,
Bill

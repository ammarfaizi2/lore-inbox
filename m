Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263136AbSJFArG>; Sat, 5 Oct 2002 20:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263141AbSJFArG>; Sat, 5 Oct 2002 20:47:06 -0400
Received: from holomorphy.com ([66.224.33.161]:6100 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263136AbSJFArF>;
	Sat, 5 Oct 2002 20:47:05 -0400
Date: Sat, 5 Oct 2002 17:50:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Gigi Duru <giduru@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
Message-ID: <20021006005048.GH10722@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, Gigi Duru <giduru@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20021005193650.17795.qmail@web13202.mail.yahoo.com> <Pine.LNX.4.44.0210052039480.20917-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210052039480.20917-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Oct 2002, Gigi Duru wrote:
>> Trivial experiment: configure out _ALL_ the options on
>> 2.5.38 and build bzImage. My result? A totally useless
>> 270KB kernel (compressed). 

On Sat, Oct 05, 2002 at 08:41:25PM -0400, Zwane Mwaikambo wrote:
> You didn't configure it properly...
> http://function.linuxpower.ca/dmesg-386-2.4.txt
> 	Zwane

I actually find this relatively disturbing:

Memory: 2584k/4352k available (881k kernel code, 1380k reserved, 171k data, 56k
init, 0k hi)

To truly scale this far downward finding ways to use less than 40% of
RAM on things allocated at or before boot-time seems necessary,
especially trimming down that 881KB.

I'll have to apologize that it's unlikely I'll be able to take any
direct action toward addressing this problem as my focus is elsewhere,
but I consider this a valid and even important concern.


Bill

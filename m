Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264962AbTAJMdR>; Fri, 10 Jan 2003 07:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264963AbTAJMdR>; Fri, 10 Jan 2003 07:33:17 -0500
Received: from holomorphy.com ([66.224.33.161]:49048 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264962AbTAJMdQ>;
	Fri, 10 Jan 2003 07:33:16 -0500
Date: Fri, 10 Jan 2003 04:41:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: spin_locks without smp.
Message-ID: <20030110124148.GQ23814@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Maciej Soltysiak <solt@dns.toxicfilms.tv>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.51.0301101238560.6124@dns.toxicfilms.tv> <20030110114546.GN23814@holomorphy.com> <1042205036.28469.78.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042205036.28469.78.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 12:42:34PM +0100, Maciej Soltysiak wrote:
>>> Which version should be practiced? i thought spinlocks are irrelevant
>>> without SMP so we should use #ifdef to shorten the execution path.

On Fri, 2003-01-10 at 11:45, William Lee Irwin III wrote:
>> Buggy on preempt. Remove the #ifdef

On Fri, Jan 10, 2003 at 01:23:56PM +0000, Alan Cox wrote:
> And render the driver unusable. Very clever. How about understanding *why*
> something was done first 8)


It's hard to see offhand (esp. w/o the hw) why increasing the
preempt_count temporarily would render it unusable. It looks like
there are deeper issues here from what you're telling me. I'll go
regroup and attempt to form some intelligent questions from your
other response.


Thanks,
Bill

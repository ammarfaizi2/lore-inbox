Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317273AbSFCFDb>; Mon, 3 Jun 2002 01:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317274AbSFCFDa>; Mon, 3 Jun 2002 01:03:30 -0400
Received: from holomorphy.com ([66.224.33.161]:25251 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317273AbSFCFDa>;
	Mon, 3 Jun 2002 01:03:30 -0400
Date: Sun, 2 Jun 2002 22:03:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make balance_classzone() use list.h
Message-ID: <20020603050307.GE14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20020602231312.GR14918@holomorphy.com> <E17EjBq-0004GG-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020602231312.GR14918@holomorphy.com> you write:
>> balance_classzone() does a number of open-coded list operations. This
>> adjusts balance_classzone() to use generic list.h operations as well
>> as renaming __freed and restructuring some of the control flow to use
>> if (unlikely(...))) goto handle_rare_case; for additional conciseness
>> and reducing the number of indentation levels required.
>> Against 2.5.19

On Mon, Jun 03, 2002 at 02:11:30PM +1000, Rusty Russell wrote:
> No, it seems to be against 2.5.19+some of your previous patches.
> The trivial patch system (almost by definition) does not handle
> interdependent patches, sorry. 8(

Ugh, it's a trivial interdependence but I'll leave this alone for
the time being.


Cheers,
Bill

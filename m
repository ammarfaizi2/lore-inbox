Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbTAJFQA>; Fri, 10 Jan 2003 00:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbTAJFP7>; Fri, 10 Jan 2003 00:15:59 -0500
Received: from holomorphy.com ([66.224.33.161]:64406 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262808AbTAJFP7>;
	Fri, 10 Jan 2003 00:15:59 -0500
Date: Thu, 9 Jan 2003 21:24:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Brian Tinsley <btinsley@emageon.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440)
Message-ID: <20030110052439.GL23814@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Brian Tinsley <btinsley@emageon.com>, linux-kernel@vger.kernel.org
References: <3E1E3B64.5040803@emageon.com> <20030110032937.GI23814@holomorphy.com> <3E1E410E.5050905@emageon.com> <20030110035412.GJ23814@holomorphy.com> <3E1E4757.3060206@emageon.com> <20030110041918.GK23814@holomorphy.com> <3E1E50FB.4000301@emageon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1E50FB.4000301@emageon.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Or perhaps the kernel version is not up-to-date. Please also provide
>> the precise kernel version (and included patches). And workload too.

On Thu, Jan 09, 2003 at 10:50:03PM -0600, Brian Tinsley wrote:
> The kernel version is stock 2.4.20 with Chris Mason's data logging and 
> journal relocation patches for ReiserFS (neither of which are actually 
> in use for any mounted filesystems). It is compiled for 64GB highmem 
> support. And just to refresh, I have seen this exact behavior on stock 
> 2.4.19 and stock 2.4.17 (no patches on either of these) also compiled 
> with 64GB highmem support.

Okay, can you try with either 2.4.x-aa or 2.5.x-CURRENT?

I'm suspecting either bh problems or lowpte problems.

Also, could you monitor your load with the scripts I posted?


Thanks,
Bill

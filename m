Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317828AbSGPJBG>; Tue, 16 Jul 2002 05:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317829AbSGPJBF>; Tue, 16 Jul 2002 05:01:05 -0400
Received: from holomorphy.com ([66.224.33.161]:56705 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317828AbSGPJBD>;
	Tue, 16 Jul 2002 05:01:03 -0400
Date: Tue, 16 Jul 2002 02:03:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] shrink task_struct by removing per_cpu utime and stime
Message-ID: <20020716090344.GB1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <20020716070943.GL1022@holomorphy.com> <1026814266.1688.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <1026814266.1688.2.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-16 at 08:09, William Lee Irwin III wrote:
>> These statistics severely bloat the task_struct and nothing in
>> userspace can rely on them as they're conditional on CONFIG_SMP. If
>> anyone is using them (or just wants them around), please speak up.

On Tue, Jul 16, 2002 at 11:11:06AM +0100, Alan Cox wrote:
> User space can rely on them because it can check if the data is present.
> Some of the graphical process monitors dump per cpu utime/stime. Its
> sometimes a good way to cringe at our SMP balancing algorithms in 2.4

If that's a "no" I can deal with it. I'm just cringing at its space
consumption and I guess we all know how oversensitive I am to that =).


Cheers,
Bill

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSIAIbC>; Sun, 1 Sep 2002 04:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSIAIbC>; Sun, 1 Sep 2002 04:31:02 -0400
Received: from holomorphy.com ([66.224.33.161]:5268 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316573AbSIAIbB>;
	Sun, 1 Sep 2002 04:31:01 -0400
Date: Sun, 1 Sep 2002 01:32:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Morten Helgesen <morten.helgesen@nextframe.net>
Cc: vantuyl@csc.smsu.edu, bryon@csc.smsu.edu, linux-kernel@vger.kernel.org
Subject: Re: [qlogicisp.c PROBLEM 2.5] OOPS: "Unable to handle kernel paging request ..."
Message-ID: <20020901083201.GN888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Morten Helgesen <morten.helgesen@nextframe.net>,
	vantuyl@csc.smsu.edu, bryon@csc.smsu.edu,
	linux-kernel@vger.kernel.org
References: <20020830103046.B107@sexything> <20020830171437.A107@sexything> <20020901103016.A1286@sexything>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020901103016.A1286@sexything>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 05:14:37PM +0200, Morten Helgesen wrote:
>> Aah - looks like it is PCI DMA related. I`ll see if I can whip up a patch
>> this weekend. 

On Sun, Sep 01, 2002 at 10:30:16AM +0200, Morten Helgesen wrote:
> Hmm ... it may actually look like though I have a hosed controller
> on my hands, and that it is actually the SCSI error handling (or lack thereof)
> that causes the oops ... something tells me that 2.4.19 is able to 'offline'
> the controller correctly, but 2.5.32 is not ...
> Bill, have you looked closer into this ? Even though a hosed controller
> is the reason for my OOPS, I guess that won`t explain the OOPS you`re seing.

I can't quite figure out what went wrong. It indexes off a NULL base
pointer in interrupt context and basically I don't have enough left of
what led to it (or enough understanding of the driver) to figure out why.


Cheers,
Bill

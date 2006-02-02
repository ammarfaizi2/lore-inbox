Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWBBPA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWBBPA6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWBBPA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:00:58 -0500
Received: from [85.8.13.51] ([85.8.13.51]:62954 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751121AbWBBPA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:00:57 -0500
Message-ID: <43E21EA0.7050100@drzeus.cx>
Date: Thu, 02 Feb 2006 16:00:48 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060128)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Purpose of MMC_DATA_MULTI?
References: <43E057DA.7000909@drzeus.cx> <20060201092934.GB27735@flint.arm.linux.org.uk> <43E08148.3060003@drzeus.cx> <20060202093656.GA5034@flint.arm.linux.org.uk> <43E1D5BF.5000807@drzeus.cx> <20060202095910.GB5034@flint.arm.linux.org.uk>
In-Reply-To: <20060202095910.GB5034@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Mainly because I don't know if that's sufficient, and until I get around
> to finding and reading the AT91RM9200 data sheet, I won't know if it is.
> What I do know is that the addition of that flag provides the exact
> information which the driver wants.
>
>   

I had a look in the spec[1] and things didn't exactly get any clearer. 
All it says is that the encoding 01 (binary) means "Multiple Block", no 
a single word on its semantics or an example of when it should be used. 
So I still advocate the simpler approach (code complexity-wise) until we 
have a test case that says it's insufficient.

Rgds
Pierre

[1] http://www.atmel.com/dyn/resources/prod_documents/doc1768.pdf

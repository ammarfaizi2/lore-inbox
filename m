Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVAMADR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVAMADR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 19:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVAMADJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 19:03:09 -0500
Received: from tim.rpsys.net ([194.106.48.114]:46247 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261326AbVAMAAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 19:00:32 -0500
Message-ID: <032a01c4f902$e1b8ec20$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Ian Molton" <spyro@f2s.com>, "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <021901c4f8eb$1e9cc4d0$0f01a8c0@max> <20050112214345.D17131@flint.arm.linux.org.uk> <023c01c4f8f3$1d497030$0f01a8c0@max> <20050112221753.F17131@flint.arm.linux.org.uk> <41E5B177.4060307@f2s.com>
Subject: Re: MMC Driver RFC
Date: Wed, 12 Jan 2005 23:58:31 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Molton:
>> That depends whether the hardware already provides 0.5s of debounce
>> already.  Some people do, some people don't.  This is why it needs to
>> be left to the implementation and not a core issue.
>
> Agreed. IIRC my toshiba PDAs *dont* provide a delay. OTOH they also 
> provide *two* ways of detecting card presence...

I hadn't realised some devices had hardware debounce and now agree its not a 
core problem.

> ISTR seeing a SD card doc at some point

The one I'm aware of is 
http://www.sdcard.org/sdio/Simplified%20Physical%20Layer%20Specification.PDF 
.

> Well I *know* I never saw the specs from the SD forum. I hacve never 
> reverse engineered a SDHC core driver either (I have reverse engineered a 
> chip driver but it contained no SD *protocol* information.
>
> as such my code should be 100% safe to commit to the kernel.

Having read things and talked to people (both before and since my posts on 
LKML), that is my conclusion as well.

> PS. Richard - I am here - hope you receive this!

I did. Have my mails to you been getting through?

Richard 


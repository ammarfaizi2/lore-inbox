Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWCZJ05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWCZJ05 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 04:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWCZJ05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 04:26:57 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:13550 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750995AbWCZJ04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 04:26:56 -0500
Date: Sun, 26 Mar 2006 11:26:41 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andreas Schwab <schwab@suse.de>
cc: Nathan Scott <nathans@sgi.com>, linux-xfs@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Parenthesize macros in xfs
In-Reply-To: <jewtei1434.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.61.0603261124320.22145@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0603202207310.20060@yvahk01.tjqt.qr>
 <20060321082327.B653275@wobbly.melbourne.sgi.com>
 <Pine.LNX.4.61.0603202239110.11933@yvahk01.tjqt.qr>
 <20060321084619.E653275@wobbly.melbourne.sgi.com>
 <Pine.LNX.4.61.0603252232570.18484@yvahk01.tjqt.qr> <je1wwq2lqn.fsf@sykes.suse.de>
 <Pine.LNX.4.61.0603260023070.12891@yvahk01.tjqt.qr> <jewtei1434.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> +		swapfunc(a, b, es, swaptype)		\
>>>> +} while(0)
>>>                                           ^^
>>>Missing semicolon.
>>
>> It was missing before too. ;)
>
>No, previously it was provided at the call site.

Bad habit IMO. It does not hurt to provide it in both the macro and 
the call site, GCC can handle empty instructions.


Jan Engelhardt
-- 

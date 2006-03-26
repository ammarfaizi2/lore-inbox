Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWCZOXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWCZOXO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 09:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWCZOXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 09:23:14 -0500
Received: from cantor.suse.de ([195.135.220.2]:4324 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751248AbWCZOXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 09:23:14 -0500
From: Andreas Schwab <schwab@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Nathan Scott <nathans@sgi.com>, linux-xfs@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Parenthesize macros in xfs
References: <Pine.LNX.4.61.0603202207310.20060@yvahk01.tjqt.qr>
	<20060321082327.B653275@wobbly.melbourne.sgi.com>
	<Pine.LNX.4.61.0603202239110.11933@yvahk01.tjqt.qr>
	<20060321084619.E653275@wobbly.melbourne.sgi.com>
	<Pine.LNX.4.61.0603252232570.18484@yvahk01.tjqt.qr>
	<je1wwq2lqn.fsf@sykes.suse.de>
	<Pine.LNX.4.61.0603260023070.12891@yvahk01.tjqt.qr>
	<jewtei1434.fsf@sykes.suse.de>
	<Pine.LNX.4.61.0603261124320.22145@yvahk01.tjqt.qr>
X-Yow: All of a sudden, I want to THROW OVER my promising ACTING CAREER,
 grow a LONG BLACK BEARD and wear a BASEBALL HAT!!
 ...  Although I don't know WHY!!
Date: Sun, 26 Mar 2006 16:23:12 +0200
In-Reply-To: <Pine.LNX.4.61.0603261124320.22145@yvahk01.tjqt.qr> (Jan
	Engelhardt's message of "Sun, 26 Mar 2006 11:26:41 +0200 (MEST)")
Message-ID: <jewtehl1yn.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>>>> +		swapfunc(a, b, es, swaptype)		\
>>>>> +} while(0)
>>>>                                           ^^
>>>>Missing semicolon.
>>>
>>> It was missing before too. ;)
>>
>>No, previously it was provided at the call site.
>
> Bad habit IMO. It does not hurt to provide it in both the macro and 
> the call site, GCC can handle empty instructions.

There is no way to provide the missing semicolon at the call site.
swapfunc can't provide it either, since it's not a macro.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

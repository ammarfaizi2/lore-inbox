Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbUCKPSl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 10:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbUCKPSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 10:18:40 -0500
Received: from ns.suse.de ([195.135.220.2]:10167 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261409AbUCKPSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 10:18:30 -0500
To: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: (0 == foo), rather than (foo == 0)
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com>
	<20040310100215.1b707504.rddunlap@osdl.org>
	<Pine.LNX.4.53.0403101324120.18709@chaos>
	<404F9E28.4040706@aurema.com>
	<Pine.LNX.4.58.0403101832580.1045@ppc970.osdl.org>
	<404FD81D.3010502@aurema.com>
	<Pine.LNX.4.58.0403101917060.1045@ppc970.osdl.org>
	<404FEDAC.8090300@stesmi.com> <yw1x7jxrzpbt.fsf@kth.se>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I'm in LOVE with DON KNOTTS!!
Date: Thu, 11 Mar 2004 16:18:29 +0100
In-Reply-To: <yw1x7jxrzpbt.fsf@kth.se> 
 =?iso-8859-1?q?=28M=E5ns_Rullg=E5rd's?= message of "Thu, 11 Mar 2004 10:48:54 +0100")
Message-ID: <je4qsvs98a.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@kth.se (Måns Rullgård) writes:

> Stefan Smietanowski <stesmi@stesmi.com> writes:
>
>> Hi Linus.
>>
>>> The warning should be there whether there are parenthesis or not,
>>> and it should state that you should have an explicit inequality
>>> expression. So if you have
>>> 	if (a = b) 		...
>>> and you really _mean_ that, then the way to write it sanely is to
>>> just write it as
>>> 	if ((a = b) != 0)
>>> 		...
>>> which makes it much clearer what you're actually doing.
>>
>> Or actually change it to
>>
>> a = b;
>> if (a)
>
> That doesn't work with while().

But this works:  while (a = b, a != 0).
(not that it is any better readable :-) ).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

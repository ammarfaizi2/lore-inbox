Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbUCKW76 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 17:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbUCKW76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 17:59:58 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:40332 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261817AbUCKW74
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 17:59:56 -0500
Message-ID: <4050F0AB.7070909@tmr.com>
Date: Thu, 11 Mar 2004 18:05:15 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefan Smietanowski <stesmi@stesmi.com>
CC: Andreas Schwab <schwab@suse.de>,
       =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: (0 == foo), rather than (foo == 0)
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com>	<20040310100215.1b707504.rddunlap@osdl.org>	<Pine.LNX.4.53.0403101324120.18709@chaos>	<404F9E28.4040706@aurema.com>	<Pine.LNX.4.58.0403101832580.1045@ppc970.osdl.org>	<404FD81D.3010502@aurema.com>	<Pine.LNX.4.58.0403101917060.1045@ppc970.osdl.org>	<404FEDAC.8090300@stesmi.com> <yw1x7jxrzpbt.fsf@kth.se> <je4qsvs98a.fsf@sykes.suse.de> <4050A506.3000703@stesmi.com>
In-Reply-To: <4050A506.3000703@stesmi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Smietanowski wrote:

>> But this works:  while (a = b, a != 0).
>> (not that it is any better readable :-) ).
> 
> 
> My eyes! *Starts clawing them out*

All in what you are used to reading. I grew up with ranges sepcified as 
something like
   0 <= x <= 40
in the spec, and therefore still write it like
   if (0 <= x && x <= 40)
because that makes it obvious (to me) that it's a range check.

A case of the language not having a range check operator and various 
people finding one thing or another readable.

-- 
		-bill

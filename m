Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVAEBXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVAEBXK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVAEBWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:22:45 -0500
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:51594 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262212AbVAEBVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:21:30 -0500
Message-ID: <41DB4131.2020400@kolivas.org>
Date: Wed, 05 Jan 2005 12:21:53 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nicholas Berry <nikberry@med.umich.edu>
Cc: grendel@caudium.net, willy@w.ods.org, linux-kernel@vger.kernel.org
Subject: Re: Very high load on P4 machines with 2.4.28
References: <s1dad55b.011@med-gwia-02a.med.umich.edu>
In-Reply-To: <s1dad55b.011@med-gwia-02a.med.umich.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Berry wrote:
>>>>Willy Tarreau <willy@w.ods.org> 01/04/05 5:05 PM >>>
>>>
>>>Oh, while I'm at it, are you using hyperthreading, and if so, could
> 
> you
> 
>>>disable it ? I have seen many cases where it degrades performances
>>>significantly (eg: highly loaded user space network applications).
> 
> 
> Indeed. AIX (sorry) 5.3 on POWER5 explicitly disables SMT (IBM
> hyperthreading) if the load doesn't warrant it.
> 
> (Now how about that for Linux?) :)

Didn't he say that it degrades performance under load? You're asking to 
disable it under low load. The 2.6 scheduler is already supposed to try 
and move tasks to full cores if they're empty instead of smt siblings.

Con

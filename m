Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbWF1AiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbWF1AiM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 20:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWF1AiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 20:38:12 -0400
Received: from sccrmhc14.comcast.net ([63.240.77.84]:17661 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932591AbWF1AiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 20:38:12 -0400
Message-ID: <44A1CF94.8030404@acm.org>
Date: Tue, 27 Jun 2006 19:38:44 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060517)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
       wim@iguana.be
Subject: Re: [PATCH] watchdog: add pretimeout ioctl
References: <20060627182225.GD10805@localdomain> <20060627172908.2116a1fa.akpm@osdl.org>
In-Reply-To: <20060627172908.2116a1fa.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, my bad, yes, it's already there.  Sorry about that.

-Corey

Andrew Morton wrote:
> minyard@acm.org wrote:
>   
>> Some watchdog timers support the concept of a "pretimeout" which
>> occurs some time before the real timeout.  The pretimeout can
>> be delivered via an interrupt or NMI and can be used to panic
>> the system when it occurs (so you get useful information instead
>> of a blind reboot).
>>
>> The IPMI watchdog has had this built in, but this creates a standard
>> mechanism for all watchdogs and switches the IPMI driver over to it.
>>     
>
> This patch seems to be kinda-sorta already half-present in Wim's
> development tree.  Could you take a look at what's in 2.6.17-mm3, see if
> any additional work is needed and if so, send a patch against that?
>
> Then we can feed it all in when (or after) Wim does his 2.6.18 merge, which
> is hopefully soon..
>   


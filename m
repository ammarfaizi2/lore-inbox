Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbUKCAwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbUKCAwU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUKBWHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:07:09 -0500
Received: from mail4.utc.com ([192.249.46.193]:49406 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S261949AbUKBWEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:04:42 -0500
Message-ID: <41880457.5000606@cybsft.com>
Date: Tue, 02 Nov 2004 16:04:07 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mark_H_Johnson@raytheon.com, Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
References: <OFB38B3DE8.983DDEAD-ON86256F40.0062F170-86256F40.0062F1A5@raytheon.com> <20041102191858.GB1216@elte.hu> <20041102192709.GA1674@elte.hu>
In-Reply-To: <20041102192709.GA1674@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>>This build appears to run OK and then in the middle of the real time
>>>tests stops doing useful work (during network test).
>>
>>weird, the deadlock detector did not trigger, although it is a clear
>>circular deadlock:
> 
> 
> ah ... found it - a fair portion of spinlocks and rwlocks had deadlock
> detection turned off in -V0.6.6 - amongst them ptype_lock. I've uploaded
> -V0.6.9 that fixes this.
> 
> 	Ingo
> 
I probably shouldn't say this, but I have yet to have -V0.6.9 die on me. 
And at least right now, the peppiness is back in the X interface, the 
menus, etc.

kr

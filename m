Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWAQTh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWAQTh6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWAQTh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:37:57 -0500
Received: from mail.dvmed.net ([216.237.124.58]:54190 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932412AbWAQTh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:37:57 -0500
Message-ID: <43CD4788.3020003@pobox.com>
Date: Tue, 17 Jan 2006 14:37:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: rostedt@goodmis.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mutex subsystem, semaphore to completion: SX8
References: <200601100207.k0A27B4J007573@hera.kernel.org> <43C31F08.304@pobox.com> <20060110100839.GA24106@elte.hu>
In-Reply-To: <20060110100839.GA24106@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Ingo Molnar wrote: > * Jeff Garzik <jgarzik@pobox.com>
	wrote: > > >>Linux Kernel Mailing List wrote: >> >>>tree
	c45749fcb6f8f22d9e2666135b528c885856aaed >>>parent
	7892f2f48d165a34b0b8130c8a195dfd807b8cb6 >>>author Steven Rostedt
	<rostedt@goodmis.org> Tue, 10 Jan 2006 07:59:26 -0800 >>>committer Ingo
	Molnar <mingo@hera.kernel.org> Tue, 10 Jan 2006 07:59:26 >>>-0800 >>>
	>>>[PATCH] mutex subsystem, semaphore to completion: SX8 >>> >>>change
	SX8 semaphores to completions. >>> >>>Signed-off-by: Ingo Molnar
	<mingo@elte.hu> >> >>Please at least CC the maintainer (me) _sometime_
	before pushing >>upstream, when you modify a driver... > > > sorry, my
	bad - this patch grew out of -rt where it initially was a > quick hack
	and then found its way into the mutex tree. Should i send a > reverse
	patch to Linus, or is this change fine with you? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> 
>>Linux Kernel Mailing List wrote:
>>
>>>tree c45749fcb6f8f22d9e2666135b528c885856aaed
>>>parent 7892f2f48d165a34b0b8130c8a195dfd807b8cb6
>>>author Steven Rostedt <rostedt@goodmis.org> Tue, 10 Jan 2006 07:59:26 -0800
>>>committer Ingo Molnar <mingo@hera.kernel.org> Tue, 10 Jan 2006 07:59:26 
>>>-0800
>>>
>>>[PATCH] mutex subsystem, semaphore to completion: SX8
>>>
>>>change SX8 semaphores to completions.
>>>
>>>Signed-off-by: Ingo Molnar <mingo@elte.hu>
>>
>>Please at least CC the maintainer (me) _sometime_ before pushing 
>>upstream, when you modify a driver...
> 
> 
> sorry, my bad - this patch grew out of -rt where it initially was a 
> quick hack and then found its way into the mutex tree. Should i send a 
> reverse patch to Linus, or is this change fine with you?

Looks fine...

	Jeff




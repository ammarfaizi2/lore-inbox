Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVGGLlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVGGLlt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 07:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVGGLjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:39:11 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:10694 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261307AbVGGLhk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:37:40 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Thu, 7 Jul 2005 12:37:42 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507071221.47946.s0348365@sms.ed.ac.uk> <20050707112936.GA26335@elte.hu>
In-Reply-To: <20050707112936.GA26335@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507071237.42470.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 Jul 2005 12:29, Ingo Molnar wrote:
> * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > Unfortunately, since this is called when the kernel crashes, it's
> > impossible for me to capture any messages prior to this spam, if there
> > even are any.
>
> this is where serial logging (or netconsole/netlogging) may be useful.
>
> do you have DEBUG_STACKOVERFLOW and latency tracing still enabled?  The
> combination of those two options is pretty good at detecting stack
> overflows. Also, you might want to enable CONFIG_4KSTACKS, that too
> disturbs the stack layout enough so that the error message may make it
> to the console.

I already have 4KSTACKS on. Latency tracing is enabled, but STACKOVERFLOW 
isn't; I'll just reenable everything again until we fix this. Do you think if 
I removed the printk() line I might get some useful information, before it 
does the stack trace?

I'm happy enough to work with this indefinitely now, at least I have a certain 
cause for the lockups, so I can continue to use the machine for R&D.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.

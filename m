Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030563AbWBAHwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030563AbWBAHwq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 02:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030564AbWBAHwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 02:52:46 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:55158 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030563AbWBAHwp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 02:52:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lm/N33AN8ShPyivdH9fYH6gn405Zmll/C0eZStlmqPpBp/2MQFTY3p17snAN0mdwW6M/VbfFyH8IGmIDp7LaSVl1yjDG5cBSBwQjFNHozWttGYvNvoYBE/4sr1LzIB0JtpWqlPOg2+gnSpcsTDo33FThEa08VgpZ8iXUEJICV+8=
Message-ID: <84144f020601312352u13c39f11w69f2e09e4c729408@mail.gmail.com>
Date: Wed, 1 Feb 2006 09:52:44 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "lkml@lazy.shacknet.nu" <lkml@lazy.shacknet.nu>
Subject: Re: kernel panic 2.6.15
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060201021331.GA500@lazy.shacknet.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060201021331.GA500@lazy.shacknet.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/1/06, lkml@lazy.shacknet.nu <lkml@lazy.shacknet.nu> wrote:
> when rendering a video with cinelerra (heavy disk io/cpu), even in
> single user mode (recent debian unstable), the kernel running on this
> computer haunts me with panic reactions.
>
> Call Trace:
>
> update_process_times
> timer_interrupt
> handle_IRQ_event

[snip, snip]

This is a hand-written trace, no? Please post the real oops. Also,
we're missing your .config. Please see REPORTING-BUGS for details.

On 2/1/06, lkml@lazy.shacknet.nu <lkml@lazy.shacknet.nu> wrote:
> PS: the render goes thru with an old 2.4.sth kernel, but not with
> 2.6.14. the system is a via kt400 based, list of modules loaded:

So you have the exact same panic under 2.6.14?

                                           Pekka

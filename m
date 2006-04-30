Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWD3Q3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWD3Q3Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 12:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWD3Q3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 12:29:25 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.7]:37131 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751160AbWD3Q3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 12:29:24 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Subject: Re: [discuss] [RFC] make PC Speaker driver work on x86-64
Date: Sun, 30 Apr 2006 17:29:32 +0100
User-Agent: KMail/1.9.1
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       Mikael Pettersson <mikpe@it.uu.se>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <200604291830.k3TIUA23009336@harpo.it.uu.se> <200604301046.22369.ak@suse.de> <878xpnt9ps.fsf@informatik.uni-tuebingen.de>
In-Reply-To: <878xpnt9ps.fsf@informatik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604301729.32008.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 April 2006 15:32, Goswin von Brederlow wrote:
> Andi Kleen <ak@suse.de> writes:
> > On Saturday 29 April 2006 20:30, Mikael Pettersson wrote:
> >> I have a pair of Athlon64 machines that dual-boot 32-bit and
> >> 64-bit kernels. One annoying difference between the kernels
> >> is that the PC Speaker driver (CONFIG_INPUT_PCSPKR=y) only
> >> works in the 32-bit kernels.
> >
> > Ah, I would consider this more a feature than a bug but ok :)
> >
> >> In the 64-bit kernels it remains
> >> inactive and doesn't even generate any boot-time initialisation
> >> or error messages.
>
> That means that the system wouldn't beep on the console or when you
> call "beep", right?
>
> With 2.6.8 x86_64 that worked without problems. Since I updated to
> 2.6.15 the system is silent.
>
> Could it be that this is a recent problem?

I think it's as described; the pcspkr driver changed in design around this 
time and needs to be plugged, now. It's probably exactly the same issue.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWD3Oer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWD3Oer (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 10:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWD3Oer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 10:34:47 -0400
Received: from mx5.Informatik.Uni-Tuebingen.De ([134.2.12.32]:4040 "EHLO
	mx5.informatik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S1751138AbWD3Oeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 10:34:46 -0400
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, Mikael Pettersson <mikpe@it.uu.se>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: [discuss] [RFC] make PC Speaker driver work on x86-64
References: <200604291830.k3TIUA23009336@harpo.it.uu.se>
	<200604301046.22369.ak@suse.de>
From: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Date: Sun, 30 Apr 2006 16:32:47 +0200
In-Reply-To: <200604301046.22369.ak@suse.de> (Andi Kleen's message of "Sun,
 30 Apr 2006 10:46:22 +0200")
Message-ID: <878xpnt9ps.fsf@informatik.uni-tuebingen.de>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Saturday 29 April 2006 20:30, Mikael Pettersson wrote:
>> I have a pair of Athlon64 machines that dual-boot 32-bit and
>> 64-bit kernels. One annoying difference between the kernels
>> is that the PC Speaker driver (CONFIG_INPUT_PCSPKR=y) only
>> works in the 32-bit kernels. 
>
> Ah, I would consider this more a feature than a bug but ok :)
>
>> In the 64-bit kernels it remains 
>> inactive and doesn't even generate any boot-time initialisation
>> or error messages.

That means that the system wouldn't beep on the console or when you
call "beep", right?

With 2.6.8 x86_64 that worked without problems. Since I updated to
2.6.15 the system is silent.

Could it be that this is a recent problem?

MfG
        Goswin

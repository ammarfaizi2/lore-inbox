Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932690AbWCQNwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbWCQNwm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932698AbWCQNwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:52:42 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:51072 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932690AbWCQNwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:52:41 -0500
Date: Fri, 17 Mar 2006 14:50:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.16-rc6-rt3
Message-ID: <20060317135029.GA4007@elte.hu>
References: <20060314084658.GA28947@elte.hu> <4416C6DD.80209@cybsft.com> <20060314142458.GA21796@elte.hu> <4416F14E.1040708@cybsft.com> <20060317092351.GA18491@elte.hu> <6bffcb0e0603170532r664142a4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0603170532r664142a4w@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> Something goes wrong.
> 
> make
> [..]
>   LD [M]  lib/zlib_inflate/zlib_inflate.o
>   LD      arch/i386/lib/built-in.o
>   CC      arch/i386/lib/bitops.o
> {standard input}: Assembler messages:
> {standard input}:429: Error: can't resolve `.sched.text' {.sched.text
> section} - `.Ltext0' {.text section}

hm, cannot reproduce that build problem here, with your config and with:

 gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)

	Ingo

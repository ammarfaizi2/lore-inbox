Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbVJLGQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbVJLGQa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 02:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbVJLGQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 02:16:30 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:42150 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932475AbVJLGQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 02:16:29 -0400
Date: Wed, 12 Oct 2005 08:16:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rc4-rt1
Message-ID: <20051012061653.GA17010@elte.hu>
References: <20051011111454.GA15504@elte.hu> <1129064151.5324.6.camel@cmn3.stanford.edu> <20051012061455.GA16586@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051012061455.GA16586@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> one tweak would be to turn off SMP support in the .config for testing 
> purposes. Another tweak would be to turn HIGH_RES_TIMERS on in the 
> .config - it is the common operating mode and the default, so non-HRT 
> timers could have attracted some bug we didnt notice yet.

a quicker tweak for your existing kernel images would be to try booting 
with maxcpus=1. This is not equivalent to turning off SMP support in the 
.config, but might make a difference already.

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWABMqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWABMqM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 07:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWABMqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 07:46:12 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:62906 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750707AbWABMqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 07:46:10 -0500
Date: Mon, 2 Jan 2006 13:46:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: "linux-kernel @ vger. kernel. org" <linux-kernel@vger.kernel.org>
Subject: Re: another BUG in 2.6.15-rc7-rt1
Message-ID: <20060102124608.GB27243@elte.hu>
References: <20060102132718.292ff55c@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060102132718.292ff55c@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> same config as last one. This one happened when a test program of mine 
> using RTC was running (midi_timer - it just simply tries to send midi 
> notes at a very regular interval). when additionally i started pmidi, 
> i got this BUG in the logs (pmidi 1.6 seemingly uses RTC, too).
> 
> I also see some other problems with RTC used in sequencers like 
> rosegarden. Sometimes everything just collapses and i get millions of 
> "RTC: lost some interrupts at X hz". I never caught the original 
> message. Will look out for it. I also suspected rosegarden tobe the 
> culprit, but it seems something _is_ going on with RTC.

could you try -rc7-rt2, does it produce the same problems? (it includes 
Steve's RTC patch, so try this only if you have not tried his patch yet)

	Ingo

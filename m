Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWBMODF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWBMODF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWBMODF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:03:05 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:10671 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751264AbWBMODD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:03:03 -0500
Date: Mon, 13 Feb 2006 15:01:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] hrtimer: remove data field
Message-ID: <20060213140120.GE12923@elte.hu>
References: <Pine.LNX.4.61.0602130211150.23843@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602130211150.23843@scrub.home>
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


* Roman Zippel <zippel@linux-m68k.org> wrote:

> Remove the it_real_value from /proc/*/stat, during 1.2.x was the last 
> time it returned useful data (as it was directly maintained by the 
> scheduler), now it's only a waste of time to calculate it.

i'm happy with this change too - but i'd not assume anything about how 
useful this is to userspace apps ... So fine for -mm and v2.6.17, but 
not for v2.6.16.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo

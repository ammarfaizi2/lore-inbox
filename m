Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751769AbWBMOAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbWBMOAI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWBMOAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:00:08 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:18871 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751705AbWBMOAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:00:05 -0500
Date: Mon, 13 Feb 2006 14:58:21 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] hrtimer: completely remove state field
Message-ID: <20060213135821.GD12923@elte.hu>
References: <Pine.LNX.4.61.0602130210480.23835@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602130210480.23835@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> Remove the state field and encode this information in the rb_node 
> similiar to normal timer.
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

yeah, this reduces struct hrtimer by a word. Definitely not for v2.6.16 
though. Fine to me for -mm and for v2.6.17.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVL0LiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVL0LiG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 06:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVL0LiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 06:38:06 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:63203 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750730AbVL0LiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 06:38:04 -0500
Date: Tue, 27 Dec 2005 12:37:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nicolas Pitre <nico@cam.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 3/3] mutex subsystem: inline mutex_is_locked()
Message-ID: <20051227113738.GA23587@elte.hu>
References: <20051223161649.GA26830@elte.hu> <Pine.LNX.4.64.0512261416370.1496@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512261416370.1496@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nicolas Pitre <nico@cam.org> wrote:

> There is currently no advantage to not always inlining 
> mutex_is_locked, even on x86.

thanks, applied.

	Ingo

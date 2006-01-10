Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWAJKId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWAJKId (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 05:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWAJKId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 05:08:33 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:56992 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751037AbWAJKIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 05:08:32 -0500
Date: Tue, 10 Jan 2006 11:08:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: rostedt@goodmis.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mutex subsystem, semaphore to completion: SX8
Message-ID: <20060110100839.GA24106@elte.hu>
References: <200601100207.k0A27B4J007573@hera.kernel.org> <43C31F08.304@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C31F08.304@pobox.com>
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


* Jeff Garzik <jgarzik@pobox.com> wrote:

> Linux Kernel Mailing List wrote:
> >tree c45749fcb6f8f22d9e2666135b528c885856aaed
> >parent 7892f2f48d165a34b0b8130c8a195dfd807b8cb6
> >author Steven Rostedt <rostedt@goodmis.org> Tue, 10 Jan 2006 07:59:26 -0800
> >committer Ingo Molnar <mingo@hera.kernel.org> Tue, 10 Jan 2006 07:59:26 
> >-0800
> >
> >[PATCH] mutex subsystem, semaphore to completion: SX8
> >
> >change SX8 semaphores to completions.
> >
> >Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> Please at least CC the maintainer (me) _sometime_ before pushing 
> upstream, when you modify a driver...

sorry, my bad - this patch grew out of -rt where it initially was a 
quick hack and then found its way into the mutex tree. Should i send a 
reverse patch to Linus, or is this change fine with you?

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267396AbUI0VQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267396AbUI0VQE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 17:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267397AbUI0VOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 17:14:03 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:38276 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267391AbUI0VMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 17:12:38 -0400
Date: Mon, 27 Sep 2004 23:14:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2-mm4
Message-ID: <20040927211412.GA24232@elte.hu>
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <200409270053.22911.gene.heskett@verizon.net> <20040927201928.GB19257@elte.hu> <1096317273.2523.5.camel@deimos.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096317273.2523.5.camel@deimos.microgate.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Fulghum <paulkf@microgate.com> wrote:

> > > Checking 'hlt' instruction... OK.
> > > -----
> > > 2.6.9-rc2-mm4 hangs here, and never gets to the next line

> > could you send me your .config?
> 
> I'm seeing the exact same thing at the same point.
> Removing pre-emptable bkl option allows boot.
> .config is attached

ok, could you re-enable bkl preemption but also enable SCHED_SMT - does
that fix the hang too?

	Ingo

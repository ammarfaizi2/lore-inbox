Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVCHGsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVCHGsS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVCHGpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:45:05 -0500
Received: from mx1.elte.hu ([157.181.1.137]:29125 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261825AbVCHGnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:43:14 -0500
Date: Tue, 8 Mar 2005 07:42:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Chris Wright <chrisw@osdl.org>
Cc: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>, paul@linuxaudiosystems.com, joq@io.com,
       cfriesen@nortelnetworks.com, hch@infradead.org, rlrevell@joe-job.com,
       arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050308064237.GA22762@elte.hu>
References: <20050112185258.GG2940@waste.org> <200501122116.j0CLGK3K022477@localhost.localdomain> <20050307195020.510a1ceb.akpm@osdl.org> <20050308043349.GG3120@waste.org> <20050307204044.23e34019.akpm@osdl.org> <422D3AB2.9020409@bigpond.net.au> <20050308054931.GA20200@elte.hu> <422D4628.8060203@bigpond.net.au> <20050308064006.GI5389@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308064006.GI5389@shell0.pdx.osdl.net>
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


* Chris Wright <chrisw@osdl.org> wrote:

> > Yes.  In kernel "damage control" is an optional extra not a necessity 
> > with this solution.  Not so sure about with the RT LSB solution though.
> 
> This has one advantage over RT LSM in that area, which is it places an
> upper bound on the priority (in control of the admin).  So it's
> possible to save some space for damage control in the top few prio
> slots.

it's not just purely for damage control - there have been requests of
being able to 'partition' the RT priorities space between applications. 
(It's an afterthought but nice nevertheless.)

	Ingo

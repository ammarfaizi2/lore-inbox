Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWBWM4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWBWM4i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 07:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWBWM4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 07:56:38 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:44683 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751195AbWBWM4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 07:56:37 -0500
Date: Thu, 23 Feb 2006 13:55:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RT : 2.6.15-rt17 and possible softlockup detected on CPU#1!
Message-ID: <20060223125513.GA12453@elte.hu>
References: <200602231354.32259.Serge.Noiraud@bull.net> <20060223124715.GA11291@elte.hu> <200602231401.40365.Serge.Noiraud@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200602231401.40365.Serge.Noiraud@bull.net>
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


* Serge Noiraud <serge.noiraud@bull.net> wrote:

> jeudi 23 Février 2006 13:47, Ingo Molnar wrote/a écrit :
> > 
> > * Serge Noiraud <serge.noiraud@bull.net> wrote:
> > 
> > > These messages occurs while my RT program loops.
> > 
> > what priority does your RT program have?
> I tried  with 10, 30, 50 and 99.

ok - the softlockup detector in -rt is a bit messy. I have written a 
more robust softlockup detector for upstream (it's now in -mm), i'll try 
to put that into the next -rt kernel. Turn it off for now ...

	Ingo

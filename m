Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVGGAXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVGGAXJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbVGFT7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:59:47 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:14778 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262306AbVGFQbN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:31:13 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Wed, 6 Jul 2005 17:31:11 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507061658.53845.s0348365@sms.ed.ac.uk> <20050706162856.GB24728@elte.hu>
In-Reply-To: <20050706162856.GB24728@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507061731.11355.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 Jul 2005 17:28, Ingo Molnar wrote:
> * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > On Wednesday 06 Jul 2005 14:39, Ingo Molnar wrote:
> > > * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > > Then it continues to boot. I'm getting periodic lockups under high
> > > > network load, however, though I suspect that might be the ipw2200
> > > > driver I compiled against the realtime-preempt kernel. Are there any
> > > > known issues with external modules versus PREEMPT-RT?
> > >
> > > you should keep an eye on compile-time warnings, but otherwise, most of
> > > the API deviations should be runtime detected and should be reported in
> > > one way or another (if you have all debugging options enabled).
> >
> > I now no longer suspect the ipw2200 module. It locks up within 5
> > minutes, reliably, with or without network load. I seem to always have
> > to promote a large redraw in X11 before it occurs, but this is just
> > hand waving, I don't really have any evidence.
>
> just to make sure: you dont have debug_direct_keyboard when using the
> console keyboard and mouse, correct? Sometimes i forget to turn it off
> and i get a crash in the keyboard or mouse irq after some time. Under X
> that often looks like a silent hard lockup.

Nope, this effect is independent of any attempt to debug the hardlock. I've 
not played with debug_direct_keyboard at all before it happens.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265033AbUFAQAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265033AbUFAQAN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 12:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbUFAQAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 12:00:13 -0400
Received: from dns1.vodatel.hr ([217.14.208.29]:29845 "EHLO dns1.vodatel.hr")
	by vger.kernel.org with ESMTP id S265033AbUFAQAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 12:00:09 -0400
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko.ursulin@zg.htnet.hr>
To: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
Subject: Re: Question about IDE disk shutdown
Date: Tue, 1 Jun 2004 17:57:13 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200406011713.59904.tvrtko.ursulin@zg.htnet.hr> <20040601154739.GA17208@bounceswoosh.org>
In-Reply-To: <20040601154739.GA17208@bounceswoosh.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406011757.13969.tvrtko.ursulin@zg.htnet.hr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 June 2004 17:47, Eric D. Mudama wrote:
> On Tue, Jun  1 at 17:13, Tvrtko A. Ur?ulin wrote:
> >According to my hard disk manual, it is absolutely recommended to put the
> >drive in STANDBY or SLEEP mode before power cut-off because in that way
> > heads are nicely parked. In that way it is guaranteed to have 300000 head
> > load/unload cycles minimum, while in other case it is just 20000 cycles.
>
> All "modern" drives have plenty of back-EMF to park the heads properly
> when power fails.

Yes, but this is a kind of uncontrollable parking with much greater mechanical 
stress. 

> Remember that even if you are limited to 20,000 power cycles reliably,
> that's over 5 reboots every day for 10 years, well over the expected
> lifetime of the drive. (unless you run windows yuk yuk)

Good point, I missed that. :) Although it would be nice if we could park the 
heads nicely. You never know which premature failure emergency parking can 
produce.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266236AbUFUOHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266236AbUFUOHp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 10:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266237AbUFUOHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 10:07:45 -0400
Received: from s150.mancelona.gtlakes.com ([64.68.227.150]:51658 "EHLO
	linux1.bmarsh.com") by vger.kernel.org with ESMTP id S266236AbUFUOHn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 10:07:43 -0400
From: Bruce Marshall <bmarsh@bmarsh.com>
Reply-To: bmarsh@bmarsh.com
To: Ragnar Hojland Espinosa <ragnar.hojland@linalco.com>
Subject: Re: Use of Moxa serial card with SMP kernels
Date: Mon, 21 Jun 2004 10:07:40 -0400
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, "Randy.Dunlap" <rddunlap@osdl.org>
References: <200406171112.39485.bmarsh@bmarsh.com> <20040617084132.510d0bcb.rddunlap@osdl.org> <20040618120355.GA22970@linalco.com>
In-Reply-To: <20040618120355.GA22970@linalco.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406211007.40186.bmarsh@bmarsh.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 June 2004 08:09 am, Ragnar Hojland Espinosa wrote:
> On Thu, Jun 17, 2004 at 08:41:32AM -0700, Randy.Dunlap wrote:
> > Both Moxa serial drivers (moxa & mxser) are BROKEN_ON_SMP because
> > they use cli() to disable interrupts for critical sections.
> > See Documentation/cli-sti-removal.txt for details.
> > They will need some acceptable modern form of protection there,
> >
> > Is anyone working on this?  not that I've heard of.
> > Have you tried this email address:
> > Copyright (C) 1999-2000  Moxa Technologies (support@moxa.com.tw).
>
> I'd try writing and asking about it;  they were very helpful when we
> had problems.

Yes, they are responsive.   Here is the current reply:

Dear Bruce,   
 
I've got updated news from the R&D Div., they are testing the latest beta 
version of the driver for all the Moxa cards, only they can not provide me 
with a precise schedule. Your case will be remaining open until it is 
resolved, I will also keep you update with the information. 
 
Best Regards, 
 
Stephen Lin / Technical Support Engineer 
 Moxa Technologies Co., Ltd.



-- 
+----------------------------------------------------------------------------+
+ Bruce S. Marshall  bmarsh@bmarsh.com  Bellaire, MI         06/21/04 10:06  +
+----------------------------------------------------------------------------+
"A billion here, a billion there, sooner or later it adds up to real
     money."       -Senator Everett Dirksen

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265134AbUFRM5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265134AbUFRM5C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 08:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265135AbUFRM5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 08:57:02 -0400
Received: from s158.mancelona.gtlakes.com ([64.68.227.158]:25256 "EHLO
	linux1.bmarsh.com") by vger.kernel.org with ESMTP id S265134AbUFRM5A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 08:57:00 -0400
From: Bruce Marshall <bmarsh@bmarsh.com>
Reply-To: bmarsh@bmarsh.com
To: Ragnar Hojland Espinosa <ragnar.hojland@linalco.com>
Subject: Re: Use of Moxa serial card with SMP kernels
Date: Fri, 18 Jun 2004 08:56:55 -0400
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, "Randy.Dunlap" <rddunlap@osdl.org>
References: <200406171112.39485.bmarsh@bmarsh.com> <20040617084132.510d0bcb.rddunlap@osdl.org> <20040618120355.GA22970@linalco.com>
In-Reply-To: <20040618120355.GA22970@linalco.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406180856.55623.bmarsh@bmarsh.com>
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

I agree....  I have written to them - they have responded already asking for 
more info - and I'm waiting to hear back from them.
-- 
+----------------------------------------------------------------------------+
+ Bruce S. Marshall  bmarsh@bmarsh.com  Bellaire, MI         06/18/04 08:56  +
+----------------------------------------------------------------------------+
"The police are not here to create disorder, they're here to preserve
    disorder"  -Former Chicago Mayor Daley during 1968 convention

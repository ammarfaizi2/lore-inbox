Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUD2VtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUD2VtF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264992AbUD2VtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:49:05 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:25100 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S264984AbUD2Vpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:45:35 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Wakko Warner <wakko@animx.eu.org>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Date: Fri, 30 Apr 2004 00:45:22 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <409021D3.4060305@fastclick.com> <40904A84.2030307@yahoo.com.au> <20040428205059.A4563@animx.eu.org>
In-Reply-To: <20040428205059.A4563@animx.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404300045.22750.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 April 2004 03:50, Wakko Warner wrote:
> > I don't know. What if you have some huge application that only
> > runs once per day for 10 minutes? Do you want it to be consuming
> > 100MB of your memory for the other 23 hours and 50 minutes for
> > no good reason?
>
> I keep soffice open all the time.  The box in question has 512mb of ram.
> This is one app, even though I use it infrequently, would prefer that it
> never be swapped out.  Mainly when I want to use it, I *WANT* it now (ie
> not waiting for it to come back from swap)

I'm afraid a part of the problem is that there are apps which are
way too bloated. Fighting bloat is thankless and hard, so almost
everybody simply throws RAM at the problem. Well. Having thrown
lotsa RAM at the problem, it may feel 'better' until you realize you
need not only RAM but *also* disk bandwidth to move bloat from disk
to RAM and back.

Come on, lets admit it. Proper fix to 'I want OpenOffice to be
responsive' problem is to make it several times smaller.
Everything else is more or less a workaround.

It's a pity size optimizations are not too popular even
on lkml.

> This is just my oppinion.  I personally feel that cache should use
> available memory, not already used memory (swapping apps out for more
> cache).
--
vda


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266107AbUA1RDu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 12:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266109AbUA1RDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 12:03:49 -0500
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:19824 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S266107AbUA1RDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 12:03:47 -0500
Date: Wed, 28 Jan 2004 18:03:41 +0100 (CET)
From: Lukasz Trabinski <lukasz@trabinski.net>
X-X-Sender: lukasz@oceanic.wsisiz.edu.pl
To: David Woodhouse <dwmw2@infradead.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, riel@redhat.com
Subject: Re: Linux 2.4.25-pre6
In-Reply-To: <1075302289.1633.158.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.58LT.0401281758470.29541@oceanic.wsisiz.edu.pl>
References: <200401202125.i0KLPOgh007806@lt.wsisiz.edu.pl> 
 <Pine.LNX.4.58L.0401201940470.29729@logos.cnet> 
 <Pine.LNX.4.58LT.0401210746350.2482@lt.wsisiz.edu.pl> 
 <Pine.LNX.4.58L.0401210852490.5072@logos.cnet> 
 <Pine.LNX.4.58LT.0401211225560.31684@oceanic.wsisiz.edu.pl> 
 <1074686081.16045.141.camel@imladris.demon.co.uk> 
 <Pine.LNX.4.58LT.0401211702100.23288@oceanic.wsisiz.edu.pl> 
 <Pine.LNX.4.58L.0401211809220.5874@logos.cnet> <1075302289.1633.158.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004, David Woodhouse wrote:

Hello.

> On Wed, 2004-01-21 at 18:12 -0200, Marcelo Tosatti wrote:
> > Lets try the clueless approach and remove the inode reclaim highmem fixes
> > from Rik.
> > 
> > Please revert the attached patch (againts -pre6).
> 
> Did this make a difference?

Machine works for 5 days without any crash or any oops.

oceanic:~# uptime
 17:58:56  up 5 days, 22:08, 28 users,  load average: 0.41, 0.53, 0.60

2.4.25-pre6 + nohighmem.patch


-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl

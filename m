Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUHRLOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUHRLOy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 07:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbUHRLOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 07:14:54 -0400
Received: from mail.humboldt.co.uk ([81.2.65.18]:26562 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S264984AbUHRLOw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 07:14:52 -0400
Subject: Re: [PATCH][2.4.27] PowerPC 745x data corruption bug fix
From: Adrian Cox <adrian@humboldt.co.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org, paulus@samba.org
In-Reply-To: <20040816170534.GA7303@smtp.west.cox.net>
References: <200408161004.i7GA48fY002331@harpo.it.uu.se>
	 <20040816170534.GA7303@smtp.west.cox.net>
Content-Type: text/plain
Message-Id: <1092827448.10314.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 18 Aug 2004 12:10:48 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 18:05, Tom Rini wrote:
> On Mon, Aug 16, 2004 at 12:04:08PM +0200, Mikael Pettersson wrote:

> > So previously a CPU got _PAGE_COHERENT on SMP.
> > Now a CPU gets _PAGE_COHERENT on (SMP || 745x).
> > 
> > I suspect the CONFIG_MPC10X_BRIDGE is an attempt to enable
> > the fix in some other cases too.
> 
> The reason CPU_FTR_NEED_COHERENT was added was to work around an MPC107
> (now Tsi107) errata.  See
> http://216.239.57.104/search?q=cache:1MDn1X8ieUUJ:www.geocrawler.com/archives/3/8358/2002/9/100/9559482/+%22Adrian+Cox%22+errata&hl=en
> (original is conn refused right now).

I've now written some notes to explain these issues, in case it comes up
again:
http://www.humboldt.co.uk/Notes/mpc107cache.html

- Adrian Cox
Humboldt Solutions Ltd.



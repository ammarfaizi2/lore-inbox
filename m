Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWFNFeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWFNFeS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 01:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWFNFeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 01:34:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:12483 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964876AbWFNFeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 01:34:17 -0400
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] x86_64 apic.h cpu_relax() (was: [RFC -mm] more cpu_relax() places?)
References: <20060612183743.GA28610@rhlx01.fht-esslingen.de>
	<20060613195430.GC24167@rhlx01.fht-esslingen.de>
From: Andi Kleen <ak@suse.de>
Date: 14 Jun 2006 07:34:07 +0200
In-Reply-To: <20060613195430.GC24167@rhlx01.fht-esslingen.de>
Message-ID: <p73k67kqp0w.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr <andi@rhlx01.fht-esslingen.de> writes:

> Hi all,
> 
> On Mon, Jun 12, 2006 at 08:37:43PM +0200, Andreas Mohr wrote:
> > Hi all,
> > 
> > while reviewing 2.6.17-rc6-mm1, I found some places that might
> > want to make use of cpu_relax() in order to not block secondary
> > pipelines while busy-polling (probably especially useful on SMT CPUs):
> 
> Patch no. 3 of 3.
> 
> This one is adding a cpu_relax() that already existed in the i386 version.
> Any reason this wasn't there, too?
> 
> Signed-off-by: Andreas Mohr <andi@lisas.de>

I merged the patch thanks.

-Andi

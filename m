Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbUKEPCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbUKEPCI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 10:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbUKEPCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 10:02:06 -0500
Received: from calvin.codito.com ([203.199.140.162]:18313 "EHLO
	magrathea.codito.co.in") by vger.kernel.org with ESMTP
	id S261632AbUKEPBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 10:01:31 -0500
From: Amit Shah <amitshah@gmx.net>
Organization: Codito Technologies
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Subject: Re: RT-preempt-2.6.10-rc1-mm2-V0.7.11 hang
Date: Fri, 5 Nov 2004 20:29:11 +0530
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <200411051837.02083.amitshah@gmx.net> <20041105134639.GA14830@elte.hu> <200411051142.43394.norberto+linux-kernel@bensa.ath.cx>
In-Reply-To: <200411051142.43394.norberto+linux-kernel@bensa.ath.cx>
X-GnuPG-Fingerprint: 3001 346D 47C2 E445 EC1B  2EE1 E8FD 8F83 4E56 1092
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411052029.13301.amitshah@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 Nov 2004 20:12, Norberto Bensa wrote:
> Ingo Molnar wrote:
> > * Amit Shah <amitshah@gmx.net> wrote:
> > > I'm trying out the RT preempt patch on a P4 HT machine, I get the
> > > following message:
> >
> > hm, does this happen with -V0.7.13 too? (note that it's against
> > 2.6.10-rc1-mm3, a newer -mm tree.)
>
> But it doesn't -cleanly- apply.
>
> Hunk #2 FAILED at 1545.
> 1 out of 2 hunks FAILED -- saving rejects to file mm/mmap.c.rej

Just ignore that hunk -- it apparently was a fix Ingo introduced for PML4, 
it's been fixed elsewhere, though.

-- 
Amit Shah
http://amitshah.nav.to/

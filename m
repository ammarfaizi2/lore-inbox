Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbVEXPgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVEXPgR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbVEXPeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:34:02 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1175 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262106AbVEXPdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:33:22 -0400
Subject: Re: [patch] Voluntary Kernel Preemption, 2.6.12-rc4-mm2
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4293466B.5070200@yahoo.com.au>
References: <20050524121541.GA17049@elte.hu>
	 <20050524132105.GA29477@elte.hu> <20050524145636.GA15943@infradead.org>
	 <20050524150950.GA10736@elte.hu>  <4293466B.5070200@yahoo.com.au>
Content-Type: text/plain
Date: Tue, 24 May 2005 17:33:12 +0200
Message-Id: <1116948792.6280.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-25 at 01:21 +1000, Nick Piggin wrote:
> IIRC, the reason (when you wrote the code) was that you didn't
> want to enable preempt either because of binary compatibility, or
> because of bugs? Well I think the bug issue is no more since your
> debug patches went in, and the compatibility reason may be a fine
> one for a distro kernel, but not a kernel.org one.

I can't imagine binary compatibility having been a reason. At least for
the RH distros it really isn't kernel wise. At All.
PREEMPT was (and is?) a stability risk and so you'll see RHEL4 not
having it enabled. But it has nothing to do with in-kernel binary
compatibility; that just doesn't exist, kernel.org or distro alike.



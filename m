Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbTAPTBZ>; Thu, 16 Jan 2003 14:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267242AbTAPTBZ>; Thu, 16 Jan 2003 14:01:25 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:9234 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267241AbTAPTBY>; Thu, 16 Jan 2003 14:01:24 -0500
Date: Thu, 16 Jan 2003 19:10:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Robert Love <rml@tech9.net>, Erich Focht <efocht@ess.nec.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
Message-ID: <20030116191009.A25749@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
	Erich Focht <efocht@ess.nec.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>,
	Andrew Theurer <habanero@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	lse-tech <lse-tech@lists.sourceforge.net>
References: <1042740441.826.55.camel@phantasy> <Pine.LNX.4.44.0301162006280.9051-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0301162006280.9051-100000@localhost.localdomain>; from mingo@elte.hu on Thu, Jan 16, 2003 at 08:07:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2003 at 08:07:09PM +0100, Ingo Molnar wrote:
> well, it needs to settle down a bit more, we are technically in a
> codefreeze :-)

We're in feature freeze.  Not sure whether fixing the scheduler for
one type of hardware supported by Linux is a feature 8)

Anyway, patch 1 should certainly merged ASAP, for the other we can wait
a bit more to settle, but I don't think it's really worth the wait.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262817AbVBCG7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbVBCG7N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 01:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbVBCG7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 01:59:13 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:22430
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262870AbVBCG7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 01:59:02 -0500
Subject: Re: ppc32 MMCR0_PMXE saga.
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>, albert_herranz@yahoo.es,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050203044702.GA1089@redhat.com>
References: <20050203044702.GA1089@redhat.com>
Content-Type: text/plain
Date: Thu, 03 Feb 2005 07:58:49 +0100
Message-Id: <1107413930.21196.637.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-02 at 23:47 -0500, Dave Jones wrote:
> I'm at a loss to explain whats been happening with this symbol.

The macro was duplicated in -mm1.
I sent a patch against -mm1
The patch went upstream without the perfctr-ppc.patch, which contained
the macro define in regs.h.

So a bit of confusion came up

tglx



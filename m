Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWDSVHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWDSVHT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 17:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWDSVHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 17:07:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:38018 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751253AbWDSVHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 17:07:17 -0400
From: Andi Kleen <ak@suse.de>
To: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: Re: [patch 2/6] Notify page fault call chain for x86_64
Date: Wed, 19 Apr 2006 23:07:03 +0200
User-Agent: KMail/1.9.1
Cc: Anderw Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@americas.sgi.com>, Dean Nelson <dnc@americas.sgi.com>,
       Tony Luck <tony.luck@intel.com>,
       Ananth Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>
References: <20060419190059.452500615@csdlinux-2.jf.intel.com> <20060419190134.862282078@csdlinux-2.jf.intel.com>
In-Reply-To: <20060419190134.862282078@csdlinux-2.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604192307.03772.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 April 2006 21:01, Anil S Keshavamurthy wrote:

You seem to be missing a description/rationale here.



-Andi

> ---
> arch/x86_64/kernel/traps.c  |   12 ++++++++++++
> arch/x86_64/mm/fault.c      |    4 ++--
> include/asm-x86_64/kdebug.h |   16 ++++++++++++++++
> 3 files changed, 30 insertions(+), 2 deletions(-)

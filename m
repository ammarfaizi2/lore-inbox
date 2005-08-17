Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVHQBiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVHQBiE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 21:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbVHQBiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 21:38:04 -0400
Received: from ozlabs.org ([203.10.76.45]:31127 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750779AbVHQBiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 21:38:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17154.38156.13295.731022@cargo.ozlabs.ibm.com>
Date: Wed, 17 Aug 2005 11:38:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@freescale.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h> 
In-Reply-To: <Pine.LNX.4.61.0508161700050.5751@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508161700050.5751@nylon.am.freescale.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala writes:

> Made <asm/segment.h> a dummy include like it is in ppc64 and removed any
> users if it in arch/ppc.

Why can't we just delete asm-ppc/segment.h (and asm-ppc64/segment.h
too, for that matter) entirely?

Paul.

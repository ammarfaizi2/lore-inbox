Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422838AbWCXKJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422838AbWCXKJq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 05:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422835AbWCXKJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 05:09:46 -0500
Received: from ozlabs.org ([203.10.76.45]:23944 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1422832AbWCXKJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 05:09:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17443.50517.434114.900607@cargo.ozlabs.ibm.com>
Date: Fri, 24 Mar 2006 21:09:25 +1100
From: Paul Mackerras <paulus@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] create struct compat_timex and use it everywhere
In-Reply-To: <20060323164623.699f569e.sfr@canb.auug.org.au>
References: <20060323164623.699f569e.sfr@canb.auug.org.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell writes:

> We had a copy of the compatibility version of struct timex in each 64 bit
> architecture.  This patch just creates a global one and replaces all the
> usages of the old ones.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Paul Mackerras <paulus@samba.org>

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWDUMGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWDUMGr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 08:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWDUMGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 08:06:47 -0400
Received: from ozlabs.org ([203.10.76.45]:23963 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932094AbWDUMGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 08:06:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17480.51661.41707.53706@cargo.ozlabs.ibm.com>
Date: Fri, 21 Apr 2006 22:02:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com (Linas Vepstas)
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: avoid crash in PCI code if mem system not up.
In-Reply-To: <20060421004042.GC7242@austin.ibm.com>
References: <20060421004042.GC7242@austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas writes:

> Please apply and forward upstream.  And a question: once 
> upon a time, the arch PCI subsystem was inited after mem init 
> was done; currently, it seems to be happening before mem init. 
> Is this intentional? 

No, and it is bogus if it is.  Do you have the full backtrace from the
crash?

Paul.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWC2WBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWC2WBG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWC2WBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:01:06 -0500
Received: from ozlabs.org ([203.10.76.45]:56809 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751010AbWC2WBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:01:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17451.866.287446.68155@cargo.ozlabs.ibm.com>
Date: Thu, 30 Mar 2006 09:00:02 +1100
From: Paul Mackerras <paulus@samba.org>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Move pSeries firmware feature setup into platforms/pseries
In-Reply-To: <20060329195212.GA19236@redhat.com>
References: <200603230714.k2N7EmH1021685@hera.kernel.org>
	<20060329195212.GA19236@redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones writes:

> This (or one of the other firmware patches, I've not narrowed it down that close)
> breaks ppc64 oprofile.
> 
> modpost now complains with..
> 
> kernel/arch/powerpc/oprofile/oprofile.ko needs unknown symbol ppc64_firmware_features

That got renamed to powerpc_firmware_features.  I don't see any
occurrences of ppc64_firmware_features left anywhere in the tree.  Are
you sure you don't just need to make clean and rebuild?

Paul.

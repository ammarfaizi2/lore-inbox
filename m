Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWBVLqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWBVLqn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 06:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWBVLqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 06:46:43 -0500
Received: from ozlabs.org ([203.10.76.45]:8941 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750847AbWBVLqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 06:46:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17404.20246.361572.784670@cargo.ozlabs.ibm.com>
Date: Wed, 22 Feb 2006 22:46:30 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alan Curry <pacman@TheWorld.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: fix altivec_unavailable_exception Oopses
In-Reply-To: <200602212339.SAA1138491@shell.TheWorld.com>
References: <200602212339.SAA1138491@shell.TheWorld.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Curry writes:

> altivec_unavailable_exception is called without setting r3... it looks like
> the r3 that actually gets passed in as struct pt_regs *regs is the
> undisturbed value of r3 at the time the altivec instruction was encountered.

Nice catch!

Thanks,
Paul.

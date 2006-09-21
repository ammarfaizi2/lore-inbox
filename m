Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWIUMfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWIUMfb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 08:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWIUMfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 08:35:31 -0400
Received: from ozlabs.org ([203.10.76.45]:32207 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751142AbWIUMfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 08:35:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17682.34548.763586.32814@cargo.ozlabs.ibm.com>
Date: Thu, 21 Sep 2006 22:35:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       mingo@elte.hu
Subject: Re: [patch 2/3] Directed yield: direct yield of spinlocks for powerpc.
In-Reply-To: <20060919111950.GD21713@skybase>
References: <20060919111950.GD21713@skybase>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky writes:

> Powerpc already has a directed yield for CONFIG_PREEMPT="n". To make
> it work with CONFIG_PREEMPT="y" as well the _raw_{spin,read,write}_relax
> primitives need to be defined to call __spin_yield() for spinlocks and
> __rw_yield() for rw-locks.

Acked-by: Paul Mackerras <paulus@samba.org>

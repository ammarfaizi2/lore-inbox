Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWERW2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWERW2M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 18:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWERW2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 18:28:12 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:23170 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750899AbWERW2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 18:28:12 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patchset] Generic IRQ Subsystem: -V4
Date: Fri, 19 May 2006 00:24:52 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>
References: <20060517001310.GA12877@elte.hu> <20060517221536.GA13444@elte.hu>
In-Reply-To: <20060517221536.GA13444@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605190024.53879.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

just a minor nit.

On Thursday, 18. May 2006 00:15, Ingo Molnar wrote:
> - sem2mutex: kernel/irq/autoprobe.c probe_sem => probe_lock mutex 
>   conversion.

Please call this probe_mutex. probe_lock would suggest, 
that this is a spin_lock() when people talk about it.

Didn't look at the actual patch, so maybe you just have a bug
in this list here :-)


Regards

Ingo Oeser

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWHGFkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWHGFkv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 01:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWHGFkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 01:40:31 -0400
Received: from cantor2.suse.de ([195.135.220.15]:21909 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751086AbWHGFk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 01:40:29 -0400
From: Andi Kleen <ak@muc.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 3/4] x86 paravirt_ops: implementation of paravirt_ops
Date: Mon, 7 Aug 2006 07:39:33 +0200
User-Agent: KMail/1.9.3
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1154925835.21647.29.camel@localhost.localdomain> <1154925943.21647.32.camel@localhost.localdomain> <1154926048.21647.35.camel@localhost.localdomain>
In-Reply-To: <1154926048.21647.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608070739.33428.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 06:47, Rusty Russell wrote:
> This patch does the dumbest possible replacement of paravirtualized
> instructions: calls through a "paravirt_ops" structure.  Currently
> these are function implementations of native hardware: hypervisors
> will override the ops structure with their own variants.

You should call it HAL - that would make it clearer what it is.

I think I would prefer to patch always. Is there a particular
reason you can't do that?

-Andi


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751659AbVKIXz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbVKIXz2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 18:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbVKIXz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 18:55:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:62896 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751658AbVKIXz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 18:55:27 -0500
Subject: Re: [PATCH] AGP performance fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Hourihane <alanh@fairlite.demon.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>
In-Reply-To: <1131579848.5973.113.camel@jetpack.demon.co.uk>
References: <200511092002.jA9K25J8025643@hera.kernel.org>
	 <1131578955.24637.116.camel@gaston>
	 <1131579848.5973.113.camel@jetpack.demon.co.uk>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 10:53:42 +1100
Message-Id: <1131580422.24637.119.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Am I supposed to define something new for uninorth-agp ? Is this yet another
> > x86-only (or worse, some x86 chipsets only concept going global ?
> 
> change global_flush_tlb() to flush_agp_mappings() and you should be
> fine.
> 
> Linus has a fix for this.

Yup, it just showed up in git, thanks.

Ben.



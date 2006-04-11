Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWDKVUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWDKVUc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 17:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWDKVUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 17:20:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:202 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751098AbWDKVUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 17:20:31 -0400
Date: Tue, 11 Apr 2006 14:21:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       arjan@infradead.org, hare@suse.de, gibbs@scsiguy.com,
       eike-kernel@sf-tec.de, stefanr@s5r6.in-berlin.de
Subject: Re: [PATCH] cleanup after deinlining patch 1/2
Message-Id: <20060411142115.4e19b1c9.akpm@osdl.org>
In-Reply-To: <200604111013.26800.vda@ilport.com.ua>
References: <200604111004.40339.vda@ilport.com.ua>
	<200604111013.26800.vda@ilport.com.ua>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@ilport.com.ua> wrote:
>
> On Tuesday 11 April 2006 10:04, Denis Vlasenko wrote:
> > * moved inlines into aic79xx_core.c and aic7xxx_core.c
> > * fixed bug in ahd_delay (made it a trivial wrapper around udelay)
> > * fixed bug in aic7xxx_pci.c (wrong order of parameters
> >   in ahc_pci_write_config calls)
> > * marked a few functions static
> > * spelling fix in error message
> 
> Won't apply t your tree because I failed to notice that you
> already included those two small fixes.
> 
> Rediffed patch (which hopefully will apply) is attached. Sorry.
> 
> > Patch which does s/__inline/inline/g will follow in a few minutes.
> 
> This one (which I already sent) should apply.

I dropped everything except for aic7xxx-ahc_pci_write_config-fix.patch.

So please resend all patches from scratch.  Preferably with accurate
Subject:s and with standalone changelogs, thanks.

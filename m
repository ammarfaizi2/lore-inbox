Return-Path: <linux-kernel-owner+w=401wt.eu-S932085AbXAOHQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbXAOHQP (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 02:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbXAOHQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 02:16:15 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:55058 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932085AbXAOHQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 02:16:13 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=Iiis07p0VtKL4Iznpv7s99M0fyQSJXmX84gMoUUS/UYTXcP9n4cg5irNEcSBFD3lOIw8D/ubBiCcTdkqaTIYT7baEPEgvoN2qRjtnCGk2E7jqsaXI5o3N3ksD7CGsxgb+4JEmGJKm/hvVSrywsBWQf0Ljr6I8Vab4yRUy1i9kng=
Date: Mon, 15 Jan 2007 09:16:02 +0200
To: Arjan van de Ven <arjan@infradead.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc5] intel_rng: substitue magic PCI IDs with macros
Message-ID: <20070115071602.GE3874@Ahmed>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org
References: <20070114172421.GA3874@Ahmed> <1168796241.3123.954.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168796241.3123.954.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2007 at 09:37:21AM -0800, Arjan van de Ven wrote:
> On Sun, 2007-01-14 at 19:24 +0200, Ahmed S. Darwish wrote:
> > Substitue intel_rng magic PCI IDs values used in the IDs table
> > with the macros defined in pci_ids.h
> > 
> Hi,
> 
> 
> hmm this is actually the opposite direction than most of the kernel is
> heading in, mostly because the pci_ids.h file is a major maintenance
> pain.
> 
> Afaik the current "rule" is: if a PCI ID is only used in one driver, use
> the numeric value and not (add) a symbolic constant.

I think you understood me wrong .. I haven't added new macros in pci_ids.h,
I've just used the macros already defined there like the PCI_VENDOR_ID_INTEL
and others.

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com

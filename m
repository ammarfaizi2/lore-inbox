Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267410AbUHRS0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267410AbUHRS0X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 14:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUHRS0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 14:26:23 -0400
Received: from the-village.bc.nu ([81.2.110.252]:16000 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267410AbUHRSZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 14:25:57 -0400
Subject: Re: Oops modprobing i830 with 2.6.8.1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Dave Jones <davej@redhat.com>,
       David =?ISO-8859-1?Q?H=E4rdeman?= <david@2gen.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040818101540.A30983@infradead.org>
References: <20040817220816.GA14343@hardeman.nu>
	 <20040817233732.GA8264@redhat.com> <20040818004339.A27701@infradead.org>
	 <20040817234522.GA4170@redhat.com> <1092801681.27352.194.camel@bach>
	 <20040818101540.A30983@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092849766.26057.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 18 Aug 2004 18:22:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-08-18 at 10:15, Christoph Hellwig wrote:
> Similarly drm should depend on AGP for those cards where there are only
> AGP versions (most of them) and the driver where pci is also posisble (some
> ati driver only IIRC) could compile with or withut but I'd be a compile-time
> thing.

VIA and SiS can function with AGP cards when no supported AGPGart is
available. They don't function as well but they do function.


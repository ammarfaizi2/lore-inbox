Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751979AbWCVCCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbWCVCCv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 21:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbWCVCCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 21:02:51 -0500
Received: from gate.crashing.org ([63.228.1.57]:45727 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751979AbWCVCCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 21:02:51 -0500
Subject: Re: [PATCH] Add SA_PERCPU_IRQ flag support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Dimitri Sivanich <sivanich@sgi.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org, jes@sgi.com
In-Reply-To: <Pine.LNX.4.64.0603211543430.14462@schroedinger.engr.sgi.com>
References: <20060321213803.GC26124@sgi.com>
	 <20060321153747.79f18016.akpm@osdl.org>
	 <Pine.LNX.4.64.0603211543430.14462@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 13:00:14 +1100
Message-Id: <1142992814.12137.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +	else
> +		BUG_ON(desc->status & IRQ_PER_CPU);

I see that you are a member of the school of brutalism ! :)

Ben.



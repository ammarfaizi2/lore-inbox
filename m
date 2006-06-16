Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWFPNuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWFPNuT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 09:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWFPNuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 09:50:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27601 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751400AbWFPNuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 09:50:16 -0400
Date: Fri, 16 Jun 2006 14:50:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, eranian@hpl.hp.com
Subject: Re: [PATCH 9/16] 2.6.17-rc6 perfmon2 patch for review: kernel-level API support (kapi)
Message-ID: <20060616135014.GB12657@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephane Eranian <eranian@frankl.hpl.hp.com>,
	linux-kernel@vger.kernel.org, eranian@hpl.hp.com
References: <200606150907.k5F97coF008178@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606150907.k5F97coF008178@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2006 at 02:07:38AM -0700, Stephane Eranian wrote:
> This patch contains the kernel-level API support.

NACK.  No one should call this from kernel space.

and apparently noting in your patchkit does either, so this is just dead code.


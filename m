Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTLTM21 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 07:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbTLTM21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 07:28:27 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:5644 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263922AbTLTM20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 07:28:26 -0500
Date: Sat, 20 Dec 2003 12:27:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>, Christoph Hellwig <hch@infradead.org>,
       akpm@osdl.org, davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating our sn code in 2.6
Message-ID: <20031220122749.A5223@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, akpm@osdl.org, davidm@napali.hpl.hp.com,
	linux-kernel@vger.kernel.org
References: <20031219114328.A26526@infradead.org> <200312200035.hBK0ZwWR005874@fsgi900.americas.sgi.com> <20031220012428.GA6654@sgi.com> <20031220030505.GB6856@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031220030505.GB6856@sgi.com>; from jbarnes@sgi.com on Fri, Dec 19, 2003 at 07:05:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 19, 2003 at 07:05:05PM -0800, Jesse Barnes wrote:
> Andrew, I'm ok with these patches (and it looks like Christoph doesn't
> find them too repulsive either) and David said he'd rather have you take
> them directly if they look ok.  Will you merge them into your tree
> please?  Like I said, this gets the tree into a very good state for
> people using Altix machines, and contains a number of important bug
> fixes.

Well, the pci-reorg patch is just wrong with tht remaining stuff
and breaks the portable I/O code for IP27 and SN2 I'm working on.
Just kill that pointless renaming and it's okay - the functional
changes are fine anyway.  Also please let Pat fix the bunch of other
issues before merging, it's not that much anyway..


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUG0Jww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUG0Jww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 05:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUG0Jww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 05:52:52 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:34823 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263085AbUG0JwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 05:52:20 -0400
Date: Tue, 27 Jul 2004 10:51:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       LSE Tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] [RFC][PATCH] Change pcibus_to_cpumask() to pcibus_to_node()
Message-ID: <20040727105145.A18533@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Dobson <colpatch@us.ibm.com>,
	Jesse Barnes <jbarnes@sgi.com>, Andi Kleen <ak@suse.de>,
	LKML <linux-kernel@vger.kernel.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	LSE Tech <lse-tech@lists.sourceforge.net>
References: <1090887007.16676.18.camel@arrakis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1090887007.16676.18.camel@arrakis>; from colpatch@us.ibm.com on Mon, Jul 26, 2004 at 05:10:08PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 05:10:08PM -0700, Matthew Dobson wrote:
> So in discussions with Jesse at OLS, we decided that pcibus_to_node() is

Please do pcibus_to_nodemask() instead - there could be dual-ported pci
bridges.


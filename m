Return-Path: <linux-kernel-owner+w=401wt.eu-S1751434AbXAKTV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbXAKTV2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbXAKTV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:21:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42995 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbXAKTV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:21:26 -0500
Date: Thu, 11 Jan 2007 19:21:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Cc: Roland Dreier <rdreier@cisco.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org,
       raisch@de.ibm.com
Subject: Re: [PATCH/RFC 2.6.21 4/5] ehca: queue pair: remove use of do_mmap()
Message-ID: <20070111192124.GC24623@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
	Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, openfabrics-ewg@openib.org,
	openib-general@openib.org, raisch@de.ibm.com
References: <200701112009.08712.hnguyen@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701112009.08712.hnguyen@linux.vnet.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 08:09:08PM +0100, Hoang-Nam Nguyen wrote:
> Hello Roland and Christoph H.!
> This is a patch for ehca_qp.c. It removes all direct calls of do_mmap()/munmap()
> when creating and destroying a queue pair respectively.

Looks good.


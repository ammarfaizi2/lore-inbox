Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbUFVIp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUFVIp1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 04:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUFVIp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 04:45:27 -0400
Received: from [213.146.154.40] ([213.146.154.40]:62337 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261422AbUFVIp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 04:45:26 -0400
Date: Tue, 22 Jun 2004 09:45:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <roland@topspin.com>
Cc: tom.l.nguyen@intel.com, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] Export msi_remove_pci_irq_vectors
Message-ID: <20040622084524.GA31737@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland Dreier <roland@topspin.com>, tom.l.nguyen@intel.com,
	linux-kernel@vger.kernel.org, greg@kroah.com
References: <52lligqqlc.fsf@topspin.com> <521xk8qlx1.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <521xk8qlx1.fsf@topspin.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 09:03:22PM -0700, Roland Dreier wrote:
> On the other hand, MSI-HOWTO.txt seems to imply that the 0th MSI
> vector should be cleaned up just by calling free_irq... so should
> pci_disable_msi be calling msi_remove_pci_irq_vectors?

I think so.


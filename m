Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbVA1S71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbVA1S71 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 13:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVA1S4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 13:56:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15080 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262753AbVA1Swi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:52:38 -0500
Date: Fri, 28 Jan 2005 18:52:34 +0000
From: Christoph Hellwig <hch@infradead.org>
To: brking@us.ibm.com
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH 1/2] pci: Arch hook to determine config space size
Message-ID: <20050128185234.GB21760@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, brking@us.ibm.com,
	greg@kroah.com, linux-kernel@vger.kernel.org,
	linuxppc64-dev@ozlabs.org
References: <200501281456.j0SEuI12020454@d01av01.pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501281456.j0SEuI12020454@d01av01.pok.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +int __attribute__ ((weak)) pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }

 - prototypes belong to headers
 - weak linkage is the perfect way for total obsfucation

please make this a regular arch hook
> Please read the FAQ at  http://www.tux.org/lkml/
---end quoted text---

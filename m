Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWBRMR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWBRMR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWBRMR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:17:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17585 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751159AbWBRMR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:17:57 -0500
Date: Sat, 18 Feb 2006 12:17:53 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org, SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com,
       HNGUYEN@de.ibm.com, MEDER@de.ibm.com
Subject: Re: [PATCH 01/22] Add powerpc-specific clear_cacheline(), which just compiles to "dcbz".
Message-ID: <20060218121753.GC911@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc64-dev@ozlabs.org, openib-general@openib.org,
	SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
	MEDER@de.ibm.com
References: <20060218005532.13620.79663.stgit@localhost.localdomain> <20060218005704.13620.88286.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218005704.13620.88286.stgit@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 04:57:04PM -0800, Roland Dreier wrote:
> From: Roland Dreier <rolandd@cisco.com>
> 
> This is horribly non-portable.

Yes.  If this is needed it should go to an asm/ header, not in a driver.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWIULob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWIULob (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 07:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWIULob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 07:44:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6840 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750949AbWIULoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 07:44:30 -0400
Date: Thu, 21 Sep 2006 12:44:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Sumant Patro <sumantp@lsil.com>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org, akpm@osdl.org,
       hch@lst.de, linux-kernel@vger.kernel.org, Neela.Kolli@lsil.com,
       Bo.Yang@lsil.com
Subject: Re: [Patch 4/7] megaraid_sas: adds reboot handler
Message-ID: <20060921114426.GA30858@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Sumant Patro <sumantp@lsil.com>, James.Bottomley@SteelEye.com,
	linux-scsi@vger.kernel.org, akpm@osdl.org, hch@lst.de,
	linux-kernel@vger.kernel.org, Neela.Kolli@lsil.com,
	Bo.Yang@lsil.com
References: <1158804171.4171.51.camel@dumbo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158804171.4171.51.camel@dumbo>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 07:02:51PM -0700, Sumant Patro wrote:
> This patch adds handler to get reboot notification and fires flush command from 
> the reboot notification handler. 

NACK, this should be handled by the PCI driver ->shutdown method instead.


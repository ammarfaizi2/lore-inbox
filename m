Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263802AbUFNTWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbUFNTWT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 15:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUFNTWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 15:22:18 -0400
Received: from [213.146.154.40] ([213.146.154.40]:9438 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263802AbUFNTWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 15:22:17 -0400
Date: Mon, 14 Jun 2004 20:22:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6: modular scsi/mca_53c9x doesn't work (fwd)
Message-ID: <20040614192215.GA5360@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>, James.Bottomley@SteelEye.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20040614185256.GJ13951@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614185256.GJ13951@fs.tum.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 08:52:56PM +0200, Adrian Bunk wrote:
> The issue described in the mail forwarded below is still present in 
> 2.6.7-rc3-mm2 (but not specific to -mm).
> 
> I'd suggest the following workaround:

Please add the exports instead.  It'll affect all the other 53C9X-based
drivers aswell.

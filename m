Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVEaOTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVEaOTr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 10:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVEaOTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 10:19:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13509 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261657AbVEaOTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 10:19:38 -0400
Date: Tue, 31 May 2005 15:19:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-pcmcia@lists.infradead.org,
       sakugawa@linux-m32r.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc5] m32r: Update m32r_cfc.[ch] to support Mappi-III platform
Message-ID: <20050531141923.GA28958@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hirokazu Takata <takata@linux-m32r.org>,
	Andrew Morton <akpm@osdl.org>, linux-pcmcia@lists.infradead.org,
	sakugawa@linux-m32r.org, linux-kernel@vger.kernel.org
References: <20050531.221702.1044949015.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050531.221702.1044949015.takata.hirokazu@renesas.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 10:17:02PM +0900, Hirokazu Takata wrote:
> Hello,
> 
> This patch is for the M32R CF/PCMCIA drivers to support a new platform,
> Mappi-III evaluation board.

Any chance you could cleanup the ifdef mess a little? e.g. adding a new
file for each platform and proper abstractions in the main source file.


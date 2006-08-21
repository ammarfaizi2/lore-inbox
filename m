Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751858AbWHUKyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbWHUKyK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 06:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbWHUKyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 06:54:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23193 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751850AbWHUKyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 06:54:08 -0400
Date: Mon, 21 Aug 2006 11:53:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/scsi/wd33c93.c: cleanups
Message-ID: <20060821105344.GA28759@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, James.Bottomley@SteelEye.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060821104357.GH11651@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821104357.GH11651@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 12:43:57PM +0200, Adrian Bunk wrote:
> This patch contains the following cleanups:
> - #include <linux/irq.h> for getting the prototypes of
>   {dis,en}able_irq()

nothing outside of arch code must ever include <linux/irq.h>


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbULJTd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbULJTd4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 14:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbULJTd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 14:33:56 -0500
Received: from [213.146.154.40] ([213.146.154.40]:34495 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261799AbULJTdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 14:33:55 -0500
Date: Fri, 10 Dec 2004 19:33:55 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Joseph Cosby <jocosby@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops: NULL Pointer With Adaptec AIC-7901X Chipset
Message-ID: <20041210193355.GA2190@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Joseph Cosby <jocosby@hotmail.com>, linux-kernel@vger.kernel.org
References: <BAY23-F4D13F4603A0C8EC362326AEA80@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY23-F4D13F4603A0C8EC362326AEA80@phx.gbl>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 12:25:51PM -0700, Joseph Cosby wrote:
> I'm getting a NULL Pointer oops with the AIC-7901X chipset from Adaptec.
> 
> Using a 2.6.9 kernel, and patching in the driver from Adaptec, I am getting 
> a NULL pointer oops as linux is booting. The Null pointer is the variable 
> sdev->request_queue, in the module scsi.c, in the function 
> scsi_adjust_queue_depth.

Can you please retry without patching in a known buggy driver?


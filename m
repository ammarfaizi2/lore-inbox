Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbUKSRtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbUKSRtv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 12:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbUKSRtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 12:49:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:718 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261514AbUKSRsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 12:48:08 -0500
Date: Fri, 19 Nov 2004 09:44:05 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 PATCH] visor: Always do generic_startup
Message-ID: <20041119174405.GE20162@kroah.com>
References: <20041116154943.GA13874@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116154943.GA13874@k3.hellgate.ch>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 04:49:43PM +0100, Roger Luethi wrote:
> generic_startup in visor.c was not called for some hardware, resulting
> in attempts to access memory that had never been allocated, which in
> turn caused the problem several people reported with recent (2.6.10ish)
> kernels.
> 
> Signed-off-by: Roger Luethi <rl@hellgate.ch>

Thanks for finding this.

Applied.

greg k-h

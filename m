Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264847AbUD2Um6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264847AbUD2Um6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264969AbUD2Um3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:42:29 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:15887 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264979AbUD2UjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:39:07 -0400
Date: Thu, 29 Apr 2004 21:39:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] I2O subsystem fixing and cleanup for 2.6 - i2o_block-cleanup.patch
Message-ID: <20040429213906.B3701@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Markus Lidel <Markus.Lidel@shadowconnect.com>,
	linux-kernel@vger.kernel.org
References: <40916624.3040502@shadowconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40916624.3040502@shadowconnect.com>; from Markus.Lidel@shadowconnect.com on Thu, Apr 29, 2004 at 10:31:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -#define I2O_LOCK(unit)	(i2ob_dev[(unit)].req_queue->queue_lock)
> -

Ahm you already did.  Sorry for the last mail.

> +	i2ob_queues[c->unit]->queue_depth ++;

	i2ob_queues[c->unit]->queue_depth++;


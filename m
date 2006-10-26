Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422870AbWJZDIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422870AbWJZDIf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 23:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422885AbWJZDIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 23:08:35 -0400
Received: from isilmar.linta.de ([213.239.214.66]:39060 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1422870AbWJZDIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 23:08:34 -0400
Date: Wed, 25 Oct 2006 22:40:04 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH] cm4000_cs: fix return value check
Message-ID: <20061026024004.GF32048@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
	Harald Welte <laforge@gnumonks.org>
References: <20061017062559.GB13100@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061017062559.GB13100@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 17, 2006 at 03:25:59PM +0900, Akinobu Mita wrote:
> The return value of class_create() need to be checked with IS_ERR().
> And register_chrdev() returns errno on failure.
> This patch includes these fixes for cm4000_cs and cm4040_cs.
> 
> Cc: Harald Welte <laforge@gnumonks.org>
> Signed-off-by: Akinbou Mita <akinobu.mita@gmail.com>

Temporarily applied to pcmica-2.6.git, thanks. Harald, do you ACK?

Thanks,
	Dominik

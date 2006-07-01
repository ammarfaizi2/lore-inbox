Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWGAWFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWGAWFW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 18:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWGAWFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 18:05:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1928 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751191AbWGAWFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 18:05:20 -0400
Subject: Re: [PATCH] Include __param section in read-only data range
From: Arjan van de Ven <arjan@infradead.org>
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060701215913.GA4298@dmt>
References: <20060701215913.GA4298@dmt>
Content-Type: text/plain
Date: Sun, 02 Jul 2006 00:05:18 +0200
Message-Id: <1151791518.3195.68.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-01 at 18:59 -0300, Marcelo Tosatti wrote:
> Hi,
> 
> The param section is an array of "kernel_param" structures, storing only
> constant data: pointer to name, permission of the variable pointed to by
> (void *)arg and pointers to set/get methods.
> 
> Move end_rodata down to include __param section in the read-only range
> used by CONFIG_DEBUG_RODATA.
> 
> Signed-off-by: Marcelo Tosatti <marcelo@kvack.org>

Acked-by: Arjan van de Ven <arjan@linux.intel.com>


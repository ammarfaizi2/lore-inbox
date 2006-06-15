Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWFPAze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWFPAze (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 20:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWFPAze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 20:55:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58327 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750819AbWFPAzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 20:55:33 -0400
Subject: Re: [PATCH -mm] tasklet_unlock_wait() cpu_relax()
From: Arjan van de Ven <arjan@infradead.org>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060614192920.GD19938@rhlx01.fht-esslingen.de>
References: <20060614192920.GD19938@rhlx01.fht-esslingen.de>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 17:34:17 +0200
Message-Id: <1150385657.2987.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-14 at 21:29 +0200, Andreas Mohr wrote:
> Hi all,
> 
> use cpu_relax() here, too (instead of barrier()).
> 
> Signed-off-by: Andreas Mohr <andi@lisas.de>

Very useful

Acked-by: Arjan van de Ven <arjan@linux.intel.com>


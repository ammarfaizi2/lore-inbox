Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750779AbWFEKDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWFEKDr (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 06:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWFEKDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 06:03:47 -0400
Received: from canuck.infradead.org ([205.233.218.70]:49097 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1750779AbWFEKDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 06:03:46 -0400
Subject: Re: [PATCH] Use ld's garbage collection feature
From: David Woodhouse <dwmw2@infradead.org>
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <20060605003152.GA1364@dmt>
References: <20060605003152.GA1364@dmt>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 11:03:42 +0100
Message-Id: <1149501822.30024.59.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-04 at 21:31 -0300, Marcelo Tosatti wrote:
> +cflags-$(CONFIG_GCSECTIONS) += -ffunction-sections

Any reason you didn't also use -fdata-sections? 

-- 
dwmw2


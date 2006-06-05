Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751146AbWFEOgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWFEOgA (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 10:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWFEOgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 10:36:00 -0400
Received: from kanga.kvack.org ([66.96.29.28]:63944 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751146AbWFEOf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 10:35:59 -0400
Date: Mon, 5 Jun 2006 11:36:36 -0300
From: Marcelo Tosatti <marcelo@kvack.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] Use ld's garbage collection feature
Message-ID: <20060605143636.GB2878@dmt>
References: <20060605003152.GA1364@dmt> <1149501822.30024.59.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149501822.30024.59.camel@pmac.infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 11:03:42AM +0100, David Woodhouse wrote:
> On Sun, 2006-06-04 at 21:31 -0300, Marcelo Tosatti wrote:
> > +cflags-$(CONFIG_GCSECTIONS) += -ffunction-sections
> 
> Any reason you didn't also use -fdata-sections? 

Not really - will try. 



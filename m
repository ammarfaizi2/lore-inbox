Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161214AbWF0R0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161214AbWF0R0k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWF0R0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:26:40 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:4287 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932485AbWF0R0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:26:39 -0400
Subject: Re: [PATCH 7/7] bootmem: miscellaneous coding style fixes
From: Dave Hansen <haveblue@us.ibm.com>
To: Franck <vagabon.xyz@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <44A12A91.5030704@innova-card.com>
References: <449FDD02.2090307@innova-card.com>
	 <1151344691.10877.44.camel@localhost.localdomain>
	 <44A12A91.5030704@innova-card.com>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 10:26:25 -0700
Message-Id: <1151429185.24103.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 14:54 +0200, Franck Bui-Huu wrote:
>  }
> +
>  /*
>   * link bdata in order
>   */
>  static void __init link_bootmem(bootmem_data_t *bdata)
>  {
>         bootmem_data_t *ent;
> +
>         if (list_empty(&bdata_list)) { 

I'd discourage you from including too many of these in your patches.
One or two is probably OK.  But, there are a bunch of them, and it isn't
clear CodingStyle to have spacing like this either way.  I'd drop them.

-- Dave


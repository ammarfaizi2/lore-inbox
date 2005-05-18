Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbVERQZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbVERQZg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVERQZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:25:27 -0400
Received: from colin.muc.de ([193.149.48.1]:1796 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262334AbVERQXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 12:23:49 -0400
Date: 18 May 2005 18:23:48 +0200
Date: Wed, 18 May 2005 18:23:48 +0200
From: Andi Kleen <ak@muc.de>
To: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Cc: akpm@osdl.org, apw@shadowen.org, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch 1/4] remove direct ref to contig_page_data for x86-64
Message-ID: <20050518162348.GB88141@muc.de>
References: <200505181523.j4IFN7rs026902@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505181523.j4IFN7rs026902@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 08:23:07AM -0700, Matt Tolentino wrote:
> 
> This patch pulls out all remaining direct references to 
> contig_page_data from arch/x86-64, thus saving an ifdef
> in one case.  

Looks good, thanks (even as a independent patch from sparsemem)

-Andi


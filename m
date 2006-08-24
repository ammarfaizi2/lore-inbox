Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751640AbWHXTQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbWHXTQj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 15:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWHXTQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 15:16:39 -0400
Received: from hera.kernel.org ([140.211.167.34]:17313 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751613AbWHXTQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 15:16:38 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [RFC] maximum latency tracking infrastructure
Date: Thu, 24 Aug 2006 15:18:14 -0400
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <1156441295.3014.75.camel@laptopd505.fenrus.org>
In-Reply-To: <1156441295.3014.75.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608241518.15227.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 August 2006 13:41, Arjan van de Ven wrote:
> Subject: [RFC] maximum latency tracking infrastructure
> From: Arjan van de Ven <arjan@linux.intel.com>
> 
> The patch below adds infrastructure to track "maximum allowable latency" for power
> saving policies.

I like it.
Stating the constraints is much nicer than today's hack where
ipw2100 reaches into ACPI and disables C3 when it notices
that DMA overflows.

everything in usecs -- good.

-Len

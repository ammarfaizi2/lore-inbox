Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVEREDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVEREDM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 00:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVEREDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 00:03:12 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:27379 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262073AbVEREDJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 00:03:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hLweQleG0oJRfDCrziEntUJtrP4xhbGCPUbNWr1kTE6UY3sjb74456T5IBHK0Nn1XtsxToVxNbKU+Tcbv1YmiiEtmRWIF/PHn/3FYrLFxNEXTtLvgHwGMXh8Nvcdq8dZU13m0TlN/rNQ8sxpTEhpl4hA5Npu2UZzMRUPOIrLluQ=
Message-ID: <311601c905051721031221db0d@mail.gmail.com>
Date: Tue, 17 May 2005 22:03:09 -0600
From: "Eric D. Mudama" <edmudama@gmail.com>
Reply-To: "Eric D. Mudama" <edmudama@gmail.com>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
In-Reply-To: <42880620.8000300@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	 <200505151121.36243.gene.heskett@verizon.net>
	 <20050515152956.GA25143@havoc.gtf.org>
	 <200505152156.18194.gene.heskett@verizon.net>
	 <42880620.8000300@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/05, Mark Lord <lkml@rtr.ca> wrote:
> There's your clue.  The drive LEDs normally reflect activity
> over the ATA bus (the cable!). If they're not on, then the drive
> isn't receiving data/commands from the host.

Mark is correct, activity indicators are associated with bus activity,
not internal drive activity.

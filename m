Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWBYLzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWBYLzV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 06:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWBYLzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 06:55:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57575 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030224AbWBYLzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 06:55:19 -0500
Date: Sat, 25 Feb 2006 11:55:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jes Sorensen <jes@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, Mark Maule <maule@sgi.com>,
       akpm@osdl.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] altix:  export sn_pcidev_info_get
Message-ID: <20060225115512.GA24439@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jes Sorensen <jes@sgi.com>, Mark Maule <maule@sgi.com>,
	akpm@osdl.org, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060214162337.GA16954@sgi.com> <20060220201713.GA4992@infradead.org> <20060221024710.GB30226@sgi.com> <20060221103633.GA19349@infradead.org> <yq0r75x6jmn.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0r75x6jmn.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 06:23:12AM -0500, Jes Sorensen wrote:
> Point is that there are cases where tuning requires you to know what
> PCI bridge is below you in order to get the best performance out of a
> card. One can keep a PCI ID blacklist to handle tuning of the PCI
> bridge itself, but it can't handle things that needs to be tuned
> by setting the PCI device's own registers.
> 
> Having a generic API to export this information would be a good thing
> IMHO.

So please submit a patch to add querying/tuning pci bridges.  And please
make it _GPL exports so people don't accidentally use it in their illegal
drivers.

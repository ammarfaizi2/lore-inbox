Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965737AbWKDXJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965737AbWKDXJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 18:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965738AbWKDXJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 18:09:28 -0500
Received: from verein.lst.de ([213.95.11.210]:34774 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S965737AbWKDXJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 18:09:27 -0500
Date: Sun, 5 Nov 2006 00:09:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@lst.de>,
       David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] add dev_to_node()
Message-ID: <20061104230916.GA32188@lst.de>
References: <20061030141501.GC7164@lst.de> <20061030.143357.130208425.davem@davemloft.net> <20061104225629.GA31437@lst.de> <20061104230648.GB640@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061104230648.GB640@redhat.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -0.349 () BAYES_30
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2006 at 06:06:48PM -0500, Dave Jones wrote:
> On Sat, Nov 04, 2006 at 11:56:29PM +0100, Christoph Hellwig wrote:
> 
> This will break the compile for !NUMA if someone ends up doing a bisect
> and lands here as a bisect point.
> 
> You introduce this nice wrapper..

Yes, I'm stupid :)  Updated version will follow ASAP.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266181AbUIALop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUIALop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 07:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUIALnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 07:43:40 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:29956 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266155AbUIALne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 07:43:34 -0400
Date: Wed, 1 Sep 2004 12:43:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: Christoph Hellwig <hch@infradead.org>, lkml@lpbproductions.com,
       Timothy Miller <miller@techsource.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 3ware queue depth [was: Re: HIGHMEM4G config for 1GB RAM on desktop?]
Message-ID: <20040901124330.A10772@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miquel van Smoorenburg <miquels@cistron.nl>,
	lkml@lpbproductions.com, Timothy Miller <miller@techsource.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <200408021602.34320.swsnyder@insightbb.com> <1094030083l.3189l.2l@traveler> <1094030194l.3189l.3l@traveler> <200409010233.31643.lkml@lpbproductions.com> <1094032735l.3189l.7l@traveler> <20040901110944.A10160@infradead.org> <1094036919l.3189l.11l@traveler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1094036919l.3189l.11l@traveler>; from miquels@cistron.nl on Wed, Sep 01, 2004 at 11:08:39AM +0000
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 11:08:39AM +0000, Miquel van Smoorenburg wrote:
> Anyway here's the minimal patch against 2.6.9-rc1
> 
> [PATCH] 3w-xxxx.c queue depth
> 
> make 3w-xxxx.c queue_depth sysfs parameter writable, adjust initial
> queue nr_requests to 2*queue_depth

Looks good to me.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271372AbTHHOIH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 10:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271374AbTHHOIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 10:08:07 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:42989 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S271372AbTHHOIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 10:08:05 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: David Woodhouse <dwmw2@infradead.org>
To: Jussi Laako <jussi.laako@pp.inet.fi>
Cc: Yury Umanets <umka@namesys.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1059239696.3036.4.camel@vaarlahti.uworld>
References: <3F1EF7DB.2010805@namesys.com>
	 <1059062380.29238.260.camel@sonja>
	 <16160.4704.102110.352311@laputa.namesys.com>
	 <1059093594.29239.314.camel@sonja>
	 <16161.10863.793737.229170@laputa.namesys.com>
	 <1059142851.6962.18.camel@sonja>
	 <1059143985.19594.3.camel@haron.namesys.com>
	 <1059181687.10059.5.camel@sonja>
	 <1059203990.21910.13.camel@haron.namesys.com>
	 <1059239696.3036.4.camel@vaarlahti.uworld>
Content-Type: text/plain
Message-Id: <1060351682.25209.482.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.1 (dwmw2) 
Date: Fri, 08 Aug 2003 15:08:02 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-26 at 18:14, Jussi Laako wrote:
> Most Linux filesystems can't be used properly with flash devices because
> of unability to handle write errors caused by flash wearing out. FS
> should mark the block as bad and relocate the data.

This is typically done by the pseudo-filesystem (FTL, NFTL, etc.) which
is used to emulate a hard drive on flash storage; the 'real' file system
itself doesn't need to do it for itself. 

-- 
dwmw2


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267973AbUHPWLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267973AbUHPWLD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267975AbUHPWLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:11:03 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:40709 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267973AbUHPWK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:10:59 -0400
Date: Mon, 16 Aug 2004 23:10:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, ecki-news2004-05@lina.inka.de,
       linux-kernel@vger.kernel.org
Subject: Re: Linux SATA RAID FAQ
Message-ID: <20040816231053.A15749@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	ecki-news2004-05@lina.inka.de, linux-kernel@vger.kernel.org
References: <E1BvFmM-0007W5-00@calista.eckenfels.6bone.ka-ip.net> <1092315392.21994.52.camel@localhost.localdomain> <20040816150641.108c66a6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040816150641.108c66a6.akpm@osdl.org>; from akpm@osdl.org on Mon, Aug 16, 2004 at 03:06:41PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 03:06:41PM -0700, Andrew Morton wrote:
> hch questioned why we need the driver at all: just put the card in JBOD
> mode and use s/w raid drivers.  But the thing does have an on-board CPU and
> the idea is that by offloading to that, the data transits the bus just a
> single time.  The developers are off doing some comparative benchmarking at
> present.

Alan's driver can use the chip in raid mode.


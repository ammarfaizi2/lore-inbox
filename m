Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932579AbVLQNSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbVLQNSK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 08:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbVLQNSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 08:18:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40090 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932579AbVLQNSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 08:18:09 -0500
Date: Sat, 17 Dec 2005 13:18:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>
Subject: Re: remove CONFIG_UID16
Message-ID: <20051217131807.GD13043@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
	Matt Mackall <mpm@selenic.com>
References: <20051217044410.GO23349@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051217044410.GO23349@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 05:44:10AM +0100, Adrian Bunk wrote:
> It seems noone noticed that CONFIG_UID16 was accidentially always 
> disabled in the latest -mm kernels.
> 
> Is there any reason against removing it completely?

Yes, it breaks backwards-compatilbity for not even that old binaries.

There's not way we're ever going to remove it.

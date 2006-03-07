Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWCGNWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWCGNWl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 08:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWCGNWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 08:22:41 -0500
Received: from penguin.cohaesio.net ([212.97.129.34]:26280 "EHLO
	mail.cohaesio.net") by vger.kernel.org with ESMTP id S1751217AbWCGNWk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 08:22:40 -0500
Subject: Re: [PATCH] Let DAC960 supply entropy to random pool
From: "Anders K. Pedersen" <akp@cohaesio.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060306174423.GY14549@waste.org>
References: <1140713078.16199.25.camel@homer.cohaesio.com>
	 <20060227000540.GN4650@waste.org>
	 <1141644324.3627.15.camel@homer.cohaesio.com>
	 <20060306174423.GY14549@waste.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Cohaesio A/S
Message-Id: <1141737483.8428.13.camel@homer.cohaesio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 07 Mar 2006 14:18:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-06 at 18:44, Matt Mackall wrote:
> On Mon, Mar 06, 2006 at 12:25:24PM +0100, Anders K. Pedersen wrote:
> > Apparently the add_disk_randomness call in ll_rw_blk.c isn't invoked for
> > my setup. There were absolutely no data available from /dev/random for
> > more than an hour (with heavy disk activity) before applying the
> > dac960.c patch, and after applying it, random data were instantly
> > available.
> 
> Ok, we probably want this patch. Please test.
> 
> Add disk entropy in DAC960 request completions.

Adding this patch (and removing mine) also provides random data, so I'm
happy with either solution.

-- 
Med venlig hilsen - Best regards

Anders K. Pedersen
Network Engineer

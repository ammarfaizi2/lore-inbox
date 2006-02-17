Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWBQRnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWBQRnv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 12:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWBQRnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 12:43:51 -0500
Received: from hera.kernel.org ([140.211.167.34]:12439 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750917AbWBQRnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 12:43:50 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] register sysfs device for lp devices
Date: Fri, 17 Feb 2006 09:43:26 -0800
Organization: OSDL
Message-ID: <20060217094326.0ae35311@localhost.localdomain>
References: <20060217113836.GA26254@pcpool00.mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1140198206 31912 10.8.0.54 (17 Feb 2006 17:43:26 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Fri, 17 Feb 2006 17:43:26 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

O
> +	parport_set_dev (p, &dev->dev);
>  	parport_announce_port (p);

Why does the parallel port code use a different whitespace style than
the rest of the kernel. It is incorrect and potentially confusing to
put a blank between the function name and the arguments. It is like
reading, english, with commas in the wrong spot.

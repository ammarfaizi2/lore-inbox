Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSHRI4A>; Sun, 18 Aug 2002 04:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSHRI4A>; Sun, 18 Aug 2002 04:56:00 -0400
Received: from ip68-4-77-172.oc.oc.cox.net ([68.4.77.172]:48376 "HELO
	ip68-4-77-172.oc.oc.cox.net") by vger.kernel.org with SMTP
	id <S312558AbSHRI4A>; Sun, 18 Aug 2002 04:56:00 -0400
Date: Sun, 18 Aug 2002 02:00:00 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Ed Sweetman <safemode@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cerberus errors on 2.4.19 (ide dma related)
Message-ID: <20020818090000.GA5154@ip68-4-77-172.oc.oc.cox.net>
References: <1029653085.674.53.camel@psuedomode> <1029655603.2970.6.camel@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029655603.2970.6.camel@psuedomode>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2002 at 03:26:42AM -0400, Ed Sweetman wrote:
> Ok, i reran the test with a little process of elimination.
> The problem occurs only when dma is enabled on the promise controller's
> harddrive. 
[snip]

Looking at your dmesg, it seems you're using a Promise controller on a
VIA chipset. AFAIK this is a known problem and the only known solution
is to avoid the VIA/Promise combo.

-Barry K. Nathan <barryn@pobox.com>

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbVH3TDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVH3TDt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 15:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVH3TDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 15:03:20 -0400
Received: from smtp3.actcom.co.il ([192.114.47.65]:21962 "EHLO
	smtp3.actcom.co.il") by vger.kernel.org with ESMTP id S932351AbVH3TDS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 15:03:18 -0400
Date: Tue, 30 Aug 2005 22:03:10 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Stephane Wirtel <stephane.wirtel@belgacom.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.13 - 1/3 - Remove the deprecated function __check_region
Message-ID: <20050830190310.GH10045@granada.merseine.nu>
References: <20050830170502.GA10694@localhost.localdomain> <9a874849050830101743c421db@mail.gmail.com> <20050830172115.GA11784@localhost.localdomain> <200508301938.00044.jesper.juhl@gmail.com> <20050830175459.GG10045@granada.merseine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050830175459.GG10045@granada.merseine.nu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 08:54:59PM +0300, Muli Ben-Yehuda wrote:
> On Tue, Aug 30, 2005 at 07:37:59PM +0200, Jesper Juhl wrote:
> > Here's a quick list of suspects for you :
> 
> [snip]
> 
> > ./sound/oss/trident.c
> 
> I'll take care of this one.

... or maybe I won't. We've been using
request_region()/release_region() since 2001 or so - your grep hit a
comment to that effect.

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


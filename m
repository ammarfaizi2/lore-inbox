Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbTAJB73>; Thu, 9 Jan 2003 20:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268099AbTAJB73>; Thu, 9 Jan 2003 20:59:29 -0500
Received: from havoc.daloft.com ([64.213.145.173]:62417 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S266718AbTAJB73>;
	Thu, 9 Jan 2003 20:59:29 -0500
Date: Thu, 9 Jan 2003 21:08:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Yan-Fa Li <yan@intruvert.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: FYI: Etherleak
Message-ID: <20030110020808.GA18605@gtf.org>
References: <D71BEAC27500D51199DF0002B328BA8D4FBF2B@ivexs1.intruvert.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D71BEAC27500D51199DF0002B328BA8D4FBF2B@ivexs1.intruvert.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 05:49:47PM -0800, Yan-Fa Li wrote:
> An interesting report into frame-padding information leakage violations in
> ethernet drivers.  The authors use linux drivers in their examples.
> 
> http://www.atstake.com/research/advisories/2003/atstake_etherleak_report.pdf

Yes.  All of those drivers are for ancient and/or obscure hardware
except three:  rtl8139, epic100, and via-rhine.

There are fixes for those (and others) in testing right now, in fact :)

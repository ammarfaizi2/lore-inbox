Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbTILKoN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 06:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbTILKoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 06:44:13 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:51350 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261421AbTILKoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 06:44:11 -0400
Subject: Re: [RFC] Enabling other oom schemes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@tech9.net>
Cc: rusty@linux.co.intel.com, riel@conectiva.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1063342229.700.240.camel@localhost>
References: <200309120219.h8C2JANc004514@penguin.co.intel.com>
	 <1063342229.700.240.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063363361.5379.3.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Fri, 12 Sep 2003 11:42:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-09-12 at 05:50, Robert Love wrote:
> But I think its a lot more useful if we have alternative overcommit
> modes to use with it.
> 
> An oom_nop might be a good idea.  But some different policies, i.e. ones
> with more determinism but less smarts, are interesting.

The overcommit is currently handled by the security layer. It is
possible the oom callback should at least in part go that way so 
a security policy can for example kill only student tasks 8)


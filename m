Return-Path: <linux-kernel-owner+w=401wt.eu-S1751830AbXAQWPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbXAQWPA (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 17:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbXAQWPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 17:15:00 -0500
Received: from farad.aurel32.net ([82.232.2.251]:15755 "EHLO mail.aurel32.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830AbXAQWO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 17:14:59 -0500
Message-ID: <45AE9FE0.7010901@aurel32.net>
Date: Wed, 17 Jan 2007 23:14:56 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
User-Agent: IceDove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Sridhar Samudrala <samudrala.sridhar@gmail.com>
CC: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Subject: Re: IPv6 router advertisement broken on 2.6.20-rc5
References: <45AD46DD.7050408@aurel32.net>	 <20070116233053.GA667@outpost.ds9a.nl> <2475a8740701161548v5758935dq51f1ed27a0c91d51@mail.gmail.com>
In-Reply-To: <2475a8740701161548v5758935dq51f1ed27a0c91d51@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sridhar Samudrala a écrit :
> I think the following patch
> 
> [IPV6] MCAST: Fix joining all-node multicast group on device initialization.
>   http://www.spinics.net/lists/netdev/msg22663.html
> 
> that went in after 2.6.20-rc5 should fix this problem.
> 

Yep that fixes the problem. Thanks a lot.

Aurelien

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

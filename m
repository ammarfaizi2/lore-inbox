Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVAXVJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVAXVJa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVAXVID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:08:03 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:16280 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261652AbVAXVFj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 16:05:39 -0500
Subject: Re: [PATCH 0/8] core-small: Introduce CONFIG_CORE_SMALL from -tiny
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050123175204.GV12076@waste.org>
References: <1.464233479@selenic.com>
	 <20050123004042.09f7f8eb.akpm@osdl.org>  <20050123175204.GV12076@waste.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106596845.10239.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 24 Jan 2005 20:00:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-01-23 at 17:52, Matt Mackall wrote:
> > Then you can lose all those ifdefs:
> > 
> > #define MAX_PROBE_HASH (255 - CONFIG_CORE_SMALL * 254)	/* dorky */
> 
> Ew.

#define		SIZE_HASH(small, large)    CONFIG_CORE_SMALL ? (small):(large)

Perhaps ?



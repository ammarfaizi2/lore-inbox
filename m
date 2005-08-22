Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbVHVUvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVHVUvQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVHVUvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:51:16 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:17835 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751095AbVHVUvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:51:16 -0400
Date: Mon, 22 Aug 2005 22:47:24 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Chris Wright <chrisw@osdl.org>
cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] SECURITY must depend on SYSFS
In-Reply-To: <20050822173003.GS7762@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.61.0508222245260.3743@scrub.home>
References: <20050822162050.GC9927@stusta.de> <20050822173003.GS7762@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 22 Aug 2005, Chris Wright wrote:

> * Adrian Bunk (bunk@stusta.de) wrote:
> >  config SECURITY
> >  	bool "Enable different security models"
> > +	depends on SYSFS
> 
> Hmm, what about select instead?

What's wrong with a normal dependency?
Please don't abuse select, use it only if you really have to.

bye, Roman

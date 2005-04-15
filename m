Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVDOFUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVDOFUp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 01:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVDOFUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 01:20:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:29852 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261710AbVDOFUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 01:20:39 -0400
Date: Thu, 14 Apr 2005 22:20:24 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: michael@ucc.gu.uwa.edu.au, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2: >100% memory usage
Message-Id: <20050414222024.059f7aa9.rddunlap@osdl.org>
In-Reply-To: <1113541145.6517.22.camel@npiggin-nld.site>
References: <20050415044806.GA12519@wibble>
	<1113541145.6517.22.camel@npiggin-nld.site>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2005 14:59:05 +1000 Nick Piggin wrote:

| On Fri, 2005-04-15 at 12:48 +0800, Michael Deegan wrote:
| > Hi folks,
| > 
| > I noticed something unusual on my home desktop machine (K6II, 448M RAM, runs
| > KDE, samba, nfsd. 2.6.12-rc2 on Debian sarge). The machine seems to feel
| > slightly sluggish; it seems to swap a fair bit more than it did under
| > 2.6.11, but at the same time it's not actually using more swap that it used
| > to. The large numbers are slowly growing larger too. The biggest spamd was
| > only 156% of memory yesterday. Normally it's only my xserver (and
| > occasionally konqueror) that manages to grab more than 10% of memory...
| 
| FWIW, me too :P
| 
| I think there is a memory leak in recent 2.6.12 kernels.
| At least on my desktop there is (although it has some of
| my own patches and I've been too lazy to do more work on
| it so I haven't reported it).
| 
| It seems to be leaking `size-4096` slabs somewhere.

This one or yet another one?
http://marc.theaimsgroup.com/?l=linux-kernel&m=111264601928365&w=2


---
~Randy

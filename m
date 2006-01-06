Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752521AbWAFS7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbWAFS7z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbWAFS7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:59:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15755 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752482AbWAFS7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:59:25 -0500
Subject: Re: [PATCH] ia64: change defconfig to NR_CPUS==1024
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Matthew Wilcox <matthew@wil.cx>,
       "Luck, Tony" <tony.luck@intel.com>, hawkes@sgi.com,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>,
       John Hesterberg <jh@sgi.com>, Greg Edwards <edwardsg@sgi.com>
In-Reply-To: <Pine.LNX.4.62.0601061035510.17875@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F055A7B6B@scsmsx401.amr.corp.intel.com>
	 <20060106174957.GF19769@parisc-linux.org>
	 <Pine.LNX.4.62.0601060958110.17665@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0601061017510.11324@shark.he.net>
	 <Pine.LNX.4.62.0601061035510.17875@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 19:59:07 +0100
Message-Id: <1136573948.2940.65.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Vendors look for the upstream defaults and orient themselves on the 
> defconfig.

they do? That's news to me. I've worked at a vendor for almost 5 years,
3 1/2 years of which I was the person who decided on the configs (with
external input of course). In those 3 1/2 years I *never* looked at
defconfig. *never*. And I don't expect other vendor kernel owners to do
things differently; when a config option needs deciding you look at the
description and pick a good value. That's it. Defconfig doesn't matter.


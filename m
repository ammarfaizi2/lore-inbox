Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUCWMvk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 07:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbUCWMvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 07:51:40 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:37306 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S262538AbUCWMvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 07:51:06 -0500
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Tue, 23 Mar 2004 13:47:42 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: remove-page-list patch in -mm breaks m68k
Message-ID: <20040323124742.GA7247@kiste>
References: <pan.2004.03.23.11.15.01.701720@smurf.noris.de> <Pine.GSO.4.58.0403231322200.4928@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0403231322200.4928@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Geert Uytterhoeven:
> Are all of these (except for m68k) converted in the mm tree?

The hugetlb stuff is covered; it basically replaces page->list with
page->lru.

> | arch/arm26/machine/small_page.c

That's missing from -mm. However, the code suggests that a patch for
arm26 would also just s/list/lru/g.

Something similar to the arm26 code might work for m68k..?

-- 
Matthias Urlichs

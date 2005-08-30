Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbVH3XLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbVH3XLX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 19:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVH3XLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 19:11:23 -0400
Received: from xenotime.net ([66.160.160.81]:41618 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932275AbVH3XLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 19:11:22 -0400
Date: Tue, 30 Aug 2005 16:11:17 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Chris Wright <chrisw@osdl.org>
cc: Pritesh Shah <pritesh.myphotos@gmail.com>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: GDT initialization and location question.
In-Reply-To: <20050830230311.GW7762@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.50.0508301609460.19488-100000@shark.he.net>
References: <6967c2bf0508301351584d6f10@mail.gmail.com>
 <20050830230311.GW7762@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2005, Chris Wright wrote:

> * Pritesh Shah (pritesh.myphotos@gmail.com) wrote:
> > I was wondering as to where is the GDT initialized during the boot
> > sequence? I will need the filename and the name of the routine that
> > does this. Any help would be greatly appreciated.
>
> Search for cpu_gdt_table (one is literal, the other is per_cpu).  You
> should be able to work it out from there.
> -

I would have said search for /gdt/ in arch/i386/boot/setup.S .
Maybe both are helpful.

-- 
~Randy

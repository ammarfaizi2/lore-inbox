Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266250AbSLTEJ3>; Thu, 19 Dec 2002 23:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267637AbSLTEJ3>; Thu, 19 Dec 2002 23:09:29 -0500
Received: from bgp926777bgs.brghtn01.mi.comcast.net ([68.41.8.22]:14977 "EHLO
	comcast.net") by vger.kernel.org with ESMTP id <S266250AbSLTEJ2>;
	Thu, 19 Dec 2002 23:09:28 -0500
Date: Thu, 19 Dec 2002 23:18:17 +0000 (UTC)
From: Alex Goddard <agoddard@purdue.edu>
To: carbonated beverage <ramune@net-ronin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: depmod errors in 2.5.52-bk
In-Reply-To: <20021219222336.GA17044@net-ronin.org>
Message-ID: <Pine.LNX.4.50L0.0212192317340.1173-100000@dust.ebiz-gw.wintek.com>
References: <20021219222336.GA17044@net-ronin.org>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2002, carbonated beverage wrote:

> Got tons of depmod errors for various symbols in a few drivers I built as
> modules, for such things as: kmalloc, __alloc_pages, schedule, etc.

Make sure you've got the latest version of module-init-tools, and that 
/sbin/depmod points to the latest version of depmod (so the kernel build 
scripts can find it).

-- 
Alex Goddard
agoddard@purdue.edu

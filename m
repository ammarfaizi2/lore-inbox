Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263408AbTDGMTY (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263409AbTDGMTY (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:19:24 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:40339
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263408AbTDGMTX (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 08:19:23 -0400
Subject: Re: [PATCH 2.5.66-ac2] PC-9800 sub architecture support (5/9) IDE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030407035231.GE4840@yuzuki.cinet.co.jp>
References: <20030407033627.GA4798@yuzuki.cinet.co.jp>
	 <20030407035231.GE4840@yuzuki.cinet.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049715151.2965.40.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Apr 2003 12:32:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-07 at 04:52, Osamu Tomita wrote:
> This is the patch to support NEC PC-9800 subarchitecture
> against 2.5.66-ac2. (5/9)
> 
> PC98 standard IDE I/F support.
>  - Change default IO port address and IRQ.
>  - Request region exactly for other optional cards.

I'm ignoring this one for the moment because one of the jobs I need
to do is to move all the resource handling in IDE into the drivers
not the core code. When that is done the problem goes away


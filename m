Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317627AbSHHQDu>; Thu, 8 Aug 2002 12:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317628AbSHHQDu>; Thu, 8 Aug 2002 12:03:50 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:49416 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S317627AbSHHQDt>;
	Thu, 8 Aug 2002 12:03:49 -0400
Date: Thu, 8 Aug 2002 18:07:12 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Anthony Russo., a.k.a. Stupendous Man" <anthony.russo@verizon.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 BUG in page_alloc.c:91
Message-ID: <20020808160712.GA18664@alpha.home.local>
References: <3D51DB52.6000200@verizon.net> <1028810336.28882.18.camel@irongate.swansea.linux.org.uk> <3D52920B.8060601@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D52920B.8060601@verizon.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 11:45:15AM -0400, Anthony Russo., a.k.a. Stupendous Man wrote:
 
> Is there a way to tell which module it is that is setting the taint flag?
> I can load each module one by one and check after each if the taint flag
> is set, but I just need to know how to tell it is set.

Modinfo could help you by telling you the licence for each module.
In the worst case, manually unload them all, and reload them one at a time.
Modprobe will issue a warning when loading such a module.

BTW, my apologies for doubting about a removed nvidia driver ;-)

Regards,
Willy


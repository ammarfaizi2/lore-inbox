Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbWK3PRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWK3PRk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 10:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWK3PRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 10:17:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48873 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030375AbWK3PRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 10:17:40 -0500
Subject: Re: kswapd/tg3 issue
From: Arjan van de Ven <arjan@infradead.org>
To: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
Cc: Alan <alan@lxorguk.ukuu.org.uk>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20061130151003.GM2021@washoe.onerussian.com>
References: <20061130144355.GK2021@washoe.onerussian.com>
	 <20061130150406.3d0b6afd@localhost.localdomain>
	 <20061130151003.GM2021@washoe.onerussian.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 30 Nov 2006 16:17:32 +0100
Message-Id: <1164899853.3233.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-30 at 10:10 -0500, Yaroslav Halchenko wrote:
> Thank you Alan
> 
> Ok - I am adding more memory in my purchasing plan ;-) For now I guess
> adding swap space should help, right?


actually since this was networking...
you probably should bump the value in

/proc/sys/vm/min_free_kbytes

a bit (like by 50%); that makes the kernel keep a bigger pool free for
emergencies/spikes...

That might be enough already if your system isn't swapping a whole lot.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267169AbSKMMTL>; Wed, 13 Nov 2002 07:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbSKMMTL>; Wed, 13 Nov 2002 07:19:11 -0500
Received: from ns.ithnet.com ([217.64.64.10]:16658 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S267169AbSKMMTK>;
	Wed, 13 Nov 2002 07:19:10 -0500
Date: Wed, 13 Nov 2002 13:25:58 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: alan@lxorguk.ukuu.org.uk
Subject: tulip driver compiled in, how to set options? (BUG in 2.4.20-rc1?)
Message-Id: <20021113132558.1ea894b3.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

can some kind soul please explain me how to set some of the options (e.g. media
type) with a compiled-in tulip driver?
I know this should work with "ether=0,0,media,.." because (as most drivers) the
media type is set via dev->mem_start. Only it does not work. I tried to find
out where the mem_start value is set in the kernel-source, starting from
alloc_etherdev up to its usage in the driver, but cannot see it. Effectively I
printk'ed it, and it is always zero.
Can someone please have a quick look if this does work at all, anywhere, anyhow
...
This is kernel 2.4.20-rc1, the whole issue is around lines 1650 in
drivers/net/tulip/tulip_core.c

-- 
Regards,
Stephan

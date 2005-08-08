Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVHHG0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVHHG0J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 02:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbVHHG0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 02:26:09 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:17573 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750738AbVHHG0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 02:26:08 -0400
Date: Mon, 8 Aug 2005 08:25:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org,
       pmarques@grupopie.com
Subject: Re: [PATCH] kernel: use kcalloc instead kmalloc/memset
In-Reply-To: <Pine.LNX.4.61.0508060151330.3728@scrub.home>
Message-ID: <Pine.LNX.4.61.0508080824500.18088@yvahk01.tjqt.qr>
References: <1123219747.20398.1.camel@localhost>  <20050804223842.2b3abeee.akpm@osdl.org>
  <Pine.LNX.4.58.0508050925370.27151@sbz-30.cs.Helsinki.FI> 
 <20050804233634.1406e92a.akpm@osdl.org>  <Pine.LNX.4.61.0508051132540.3743@scrub.home>
  <1123235219.3239.46.camel@laptopd505.fenrus.org>  <Pine.LNX.4.61.0508051202520.3728@scrub.home>
  <1123236831.3239.55.camel@laptopd505.fenrus.org>  <Pine.LNX.4.61.0508051225270.3743@scrub.home>
  <1123238289.3239.57.camel@laptopd505.fenrus.org>  <Pine.LNX.4.61.0508051254010.3743@scrub.home>
 <1123240325.3239.62.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0508060151330.3728@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>What prevents a rogue user to call this function a number of times to 
>waste resources?

Sorry to jump in, but wasting resources is a different matter than 
overwriting kernel memory.



Jan Engelhardt
-- 

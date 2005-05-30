Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVE3Iym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVE3Iym (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 04:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVE3Iyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 04:54:41 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:31548 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261566AbVE3Iy2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 04:54:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=diHEddy1VT+G9JC/owdRpBSvlRRzowoEXUYyFGY5H5tfzTGkXEPaOglglvdek+lojfH7VuBteSE7P0t+F+bcR5UOoJ+jLRewI2wZgHV4AS/l9IxEBSG+DguX+Mue6jRJqmtu/v4GxG1ojfHT6Y3C9IkhFlRpsGDJBsaVwL9Lvuw=
Message-ID: <21d7e99705053001544fe883d5@mail.gmail.com>
Date: Mon, 30 May 2005 18:54:28 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] DRM depends on ???
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Dave Airlie <airlied@linux.ie>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.62.0505301002400.22798@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.62.0505282333210.5800@anakin>
	 <20050528215005.GA5990@redhat.com>
	 <1FA58BE7-0EE6-432B-9383-F489F9854DBE@mac.com>
	 <Pine.LNX.4.58.0505290809180.9971@skynet>
	 <Pine.LNX.4.62.0505292157130.12948@numbat.sonytel.be>
	 <64148E06-2DFA-41A5-9D86-5F34DCAAF9F4@mac.com>
	 <Pine.LNX.4.62.0505301002400.22798@numbat.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK. So we still need the dependency on PCI.
> 

at the moment yes but I'm think we will have to remove this as soon as
we get the Sparc ffb stuff up and running again, the ffb driver
doesn't do any PCI stuff, we have some code around but we haven't had
any testing done on it and I'm sure its rotting away, if a maintainer
turns up for sparc ffb, then the PCI requirement is gone..

If Christoph is correct I'll clean it up to use the construct he
suggests, no-one came up with that solution when this was asked
originally a few kernels back..

I can add the PCI dependency for now...

Dave.

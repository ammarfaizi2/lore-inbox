Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266835AbUIEPrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266835AbUIEPrY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 11:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266821AbUIEPrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 11:47:24 -0400
Received: from the-village.bc.nu ([81.2.110.252]:33692 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266820AbUIEPrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 11:47:11 -0400
Subject: Re: New proposed DRM interface design
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Keith Whitwell <keith@tungstengraphics.com>, Dave Jones <davej@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mharris@redhat.com
In-Reply-To: <9e473391040905083326707923@mail.gmail.com>
References: <20040904102914.B13149@infradead.org>
	 <4139B03A.6040706@tungstengraphics.com> <20040904122057.GC26419@redhat.com>
	 <4139C8A3.6010603@tungstengraphics.com>
	 <9e47339104090408362a356799@mail.gmail.com>
	 <4139FEB4.3080303@tungstengraphics.com>
	 <9e473391040904110354ba2593@mail.gmail.com>
	 <1094386050.1081.33.camel@localhost.localdomain>
	 <9e47339104090508052850b649@mail.gmail.com>
	 <1094393713.1264.7.camel@localhost.localdomain>
	 <9e473391040905083326707923@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094395462.1271.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 05 Sep 2004 15:44:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-09-05 at 16:33, Jon Smirl wrote:
> Then how am I going to merge fbdev and DRM so that we don't have two
> drivers fighting over the same hardware? 

Everyone else in the discussions but you seemed to have no plans to
merge them, yet you keep going back to that plan and ignoring the other
opinions.

If you are merging them then something is wrong in the design. The only
things they fundamentally share are knowledge of the current display
layout, and state management for rendering. 

As you say "if BSD isn't even going to use the code". So why are you
trying to make it hard for the BSD side ? They've got a perfectly good
frame buffer layer too and not suprisingly it has the same requirements
for knowledge.

Alan


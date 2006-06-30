Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933126AbWF3T0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933126AbWF3T0Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 15:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933148AbWF3T0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 15:26:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12195 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933126AbWF3T0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 15:26:23 -0400
Date: Fri, 30 Jun 2006 15:26:09 -0400
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Alessio Sangalli <alesan@manoweb.com>,
       Andrew Morton <akpm@osdl.org>, alan@lxorguk.ukuu.org.uk,
       penberg@cs.Helsinki.FI, linux-kernel@vger.kernel.org,
       ink@jurassic.park.msu.ru, dtor_core@ameritech.net
Subject: Re: [PATCH] cardbus: revert IO window limit
Message-ID: <20060630192609.GQ32729@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Alessio Sangalli <alesan@manoweb.com>,
	Andrew Morton <akpm@osdl.org>, alan@lxorguk.ukuu.org.uk,
	penberg@cs.Helsinki.FI, linux-kernel@vger.kernel.org,
	ink@jurassic.park.msu.ru, dtor_core@ameritech.net
References: <Pine.LNX.4.58.0606220947250.15059@sbz-30.cs.Helsinki.FI> <20060622001104.9e42fc54.akpm@osdl.org> <1150976158.15275.148.camel@localhost.localdomain> <Pine.LNX.4.64.0606220917080.5498@g5.osdl.org> <20060622093606.2b3b1eb7.akpm@osdl.org> <Pine.LNX.4.64.0606221005410.5498@g5.osdl.org> <449B0B3C.2020904@manoweb.com> <Pine.LNX.4.64.0606301200400.12404@g5.osdl.org> <20060630191914.GP32729@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630191914.GP32729@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 03:19:14PM -0400, Dave Jones wrote:

 >  > Ok. We don't actually have any quirks at all for the 82440MX, and that's 
 >  > almost certainly _not_ because it doesn't do something strange (all Intel 
 >  > host bridges have magic IO ranges), but simply because we haven't hit it 
 >  > yet.
 >  > 
 >  > And I can't find the docs for the PCI config space for that dang thing.
 >  > 
 >  > I bet that there's some magic SMBus IO-range that the 440MX decodes using 
 >  > a special magic config setting.
 >  > 
 >  > Has anybody found the config space docs for the 82440MX? 
 > 
 > http://www.codemonkey.org.uk/cruft/440/
 > There's an assortment of docs for the other flavour Intel PCIsets from
 > that era in the same dir.

Hrmm, actually that seems to have everything *but* config space definitions.
I'm not sure if that was ever published in that case, as when I grabbed these
many years ago, I'd grab everything in sight, and I was something of a pack-rat
and never threw away datasheets.

But maybe some other chipset archaeologist was more of a packrat than I was :-)

		Dave

-- 
http://www.codemonkey.org.uk

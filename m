Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUIDQAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUIDQAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 12:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUIDQAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 12:00:09 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:60625 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263448AbUIDQAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 12:00:00 -0400
Message-ID: <9e47339104090408598631026@mail.gmail.com>
Date: Sat, 4 Sep 2004 11:59:59 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>
Subject: Re: New proposed DRM interface design
Cc: dri-devel@lists.sf.net, Dave Airlie <airlied@linux.ie>,
       linux-kernel@vger.kernel.org
In-Reply-To: <2191E8A1-FE89-11D8-BFDA-000A95F07A7A@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0409040107190.18417@skynet>
	 <a728f9f904090317547ca21c15@mail.gmail.com>
	 <Pine.LNX.4.58.0409040158400.25475@skynet>
	 <9e4733910409032051717b28c0@mail.gmail.com>
	 <Pine.LNX.4.58.0409040548490.25475@skynet>
	 <9e47339104090323047b75dbb2@mail.gmail.com>
	 <2191E8A1-FE89-11D8-BFDA-000A95F07A7A@fs.ei.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Sep 2004 17:43:13 +0200, Simon 'corecode' Schubert
<corecode@fs.ei.tum.de> wrote:
> I think David Airlie broke it already before. Yes I am using DRM on
> DragonFlyBSD and yes there are lots of people who'd like to use it on
> *BSD too. I just didn't want to stomp right in and scream "you break it
> - fix it!". Actually I hoped that the linux specific parts would be
> abstracted again so that it wouldn't break on BSD. As I'm not following
> cvs mailings I hoped Erik Anholt would fix the broken parts, but he's
> busy I think.
> 
> But as it seems that you want to hear people scream when something
> broke, okay. I will happily post breakes and - if I'm able to do so -
> also fixes to this.

BSD developers need to keep an eye on DRM and make sure it doesn't get
totally broken for them. There are DRM developers (like me) that have
never even booted a BSD system and haven't got a clue about it's
kernel API.

I'm a little concerned that we are doing a lot of work to support a
few people (<100) using DRM on BSD. I suspicious that it is a very
small number since we get close to zero complaints about BSD even
though we break it continuously.

I'm also not proposing to shut BSD out of the DRM code base. I'm
trying to merge fbdev and DRM into a single, unified video
architecture on Linux.  Linux is GPL so half of this merge code base
(fbdev) is GPL code. Mixing the GPL code into the DRM code base will
convert it's license from BSD to GPL. No one is proposing removing BSD
support from DRM.

So from a BSD perspective which is worse, converting DRM to a GPL
license or forking DRM into Linux and BSD versions?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUIDVgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUIDVgH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 17:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUIDVgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 17:36:04 -0400
Received: from smtp.easystreet.com ([69.30.22.10]:19093 "EHLO
	smtp.easystreet.com") by vger.kernel.org with ESMTP id S262085AbUIDVfr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 17:35:47 -0400
Subject: Re: New proposed DRM interface design
From: Eric Anholt <eta@lclark.edu>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>,
       DRI <dri-devel@lists.sourceforge.net>, Dave Airlie <airlied@linux.ie>,
       linux-kernel@vger.kernel.org
In-Reply-To: <9e47339104090408598631026@mail.gmail.com>
References: <Pine.LNX.4.58.0409040107190.18417@skynet>
	 <a728f9f904090317547ca21c15@mail.gmail.com>
	 <Pine.LNX.4.58.0409040158400.25475@skynet>
	 <9e4733910409032051717b28c0@mail.gmail.com>
	 <Pine.LNX.4.58.0409040548490.25475@skynet>
	 <9e47339104090323047b75dbb2@mail.gmail.com>
	 <2191E8A1-FE89-11D8-BFDA-000A95F07A7A@fs.ei.tum.de>
	 <9e47339104090408598631026@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1094333740.935.104.camel@leguin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 04 Sep 2004 14:35:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-04 at 08:59, Jon Smirl wrote:
> On Sat, 4 Sep 2004 17:43:13 +0200, Simon 'corecode' Schubert
> <corecode@fs.ei.tum.de> wrote:
> > I think David Airlie broke it already before. Yes I am using DRM on
> > DragonFlyBSD and yes there are lots of people who'd like to use it on
> > *BSD too. I just didn't want to stomp right in and scream "you break it
> > - fix it!". Actually I hoped that the linux specific parts would be
> > abstracted again so that it wouldn't break on BSD. As I'm not following
> > cvs mailings I hoped Erik Anholt would fix the broken parts, but he's
> > busy I think.
> > 
> > But as it seems that you want to hear people scream when something
> > broke, okay. I will happily post breakes and - if I'm able to do so -
> > also fixes to this.
> 
> BSD developers need to keep an eye on DRM and make sure it doesn't get
> totally broken for them. There are DRM developers (like me) that have
> never even booted a BSD system and haven't got a clue about it's
> kernel API.
> 
> I'm a little concerned that we are doing a lot of work to support a
> few people (<100) using DRM on BSD. I suspicious that it is a very
> small number since we get close to zero complaints about BSD even
> though we break it continuously.

FreeBSD and DFBSD have the DRM integrated into the kernel tree, and it
works just great (i.e. no configuration except for Section "DRI") for
our users.  I only get complaints when someone has some new PCI ID, or
when there's some issue in an AGP driver.  Nobody actively uses DRI
CVS's DRM, because I fix DRI CVS and merge to -current whenever there
are major differences, and people on 4-stable generally just grab the
DRM code from -current since I maintain source-level compatibility.

So this is why you don't really hear complaints from BSD users on
dri-devel.  But there are quite a number from them.  I've certainly
heard from over a hundred, and of course that's a tiny fraction of the
total number.

-- 
Eric Anholt                                eta@lclark.edu          
http://people.freebsd.org/~anholt/         anholt@FreeBSD.org



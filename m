Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUA0Hkv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 02:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbUA0Hkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 02:40:51 -0500
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2]:52505 "EHLO
	iris1.csv.ica.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id S262328AbUA0Hkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 02:40:49 -0500
Date: Tue, 27 Jan 2004 08:40:35 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: monochrome display fix.
Message-ID: <20040127074035.GF1315@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.LNX.4.44.0401262212140.5445-100000@phoenix.infradead.org> <Pine.LNX.4.58.0401261446560.2313@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401261446560.2313@home.osdl.org>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> 
> On Mon, 26 Jan 2004, James Simmons wrote:
> > 
> > [CONSOLE] Don't let a monochrome display stomp all over the console color 
> > values.
> 
> Why is this ugly patch required? If something can't do color, why does it 
> care about "color" in the first place?

Because it stores some text attributes in that place.

> We've never needed this patch 
> before, it looks like something broke somewhere _else_ that causes this
> to be relevant.

It was always broken. This went unnoticed, apparently nobody tried to use
a kernel which supports mono and colour framebuffers at the same time.


Thiemo

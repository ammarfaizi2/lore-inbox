Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVG1UTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVG1UTZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVG1UR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:17:27 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:31953 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261726AbVG1UPl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:15:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e0UA8QkTA3Rm9oQ7cC6uyjfLZnj2dbxd5UQTPglBsxGTimzzJ2fAIFX79Xg27oGZnl0qZCatTn5EVm4Fc7Fe8Ylygz/oexMDvqK/Dk6Ncogzgeqk/lAhUq5vCK7PN8+/ns2jLOp9a6yRozxNIZBiQXcZNg8e/yzQBmyR1jP3/hI=
Message-ID: <9e4733910507281315419c3c12@mail.gmail.com>
Date: Thu, 28 Jul 2005 16:15:40 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: colormap fixes
Cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0507282202450.29876@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507280031.j6S0V3L3016861@hera.kernel.org>
	 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be>
	 <9e473391050728060741040424@mail.gmail.com>
	 <42E8F0CD.6070500@gmail.com>
	 <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>
	 <9e473391050728092936794718@mail.gmail.com>
	 <9e47339105072811183ac0f008@mail.gmail.com>
	 <Pine.LNX.4.62.0507282202450.29876@numbat.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, 28 Jul 2005, Jon Smirl wrote:
> > I can't see a way to query how long of cmap the device supports using
> > the current fbdev ioctls.
> 
> Look at the lengths of the color bitfields?

Which color bitfields? Does hardware that supports 10bit cmap also
support a 10:10:10 framebuffer? If you can't do 10:10:10 how do the
10bit cmaps work?  Does alpha matter in a 10:10:10 scanout buffer?

-- 
Jon Smirl
jonsmirl@gmail.com

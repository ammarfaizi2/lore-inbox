Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268072AbUIGOEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268072AbUIGOEn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268076AbUIGOEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:04:43 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:30220 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268072AbUIGOEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:04:41 -0400
Message-ID: <9e47339104090707045d009de6@mail.gmail.com>
Date: Tue, 7 Sep 2004 10:04:37 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Helge Hafting <helge.hafting@hist.no>
Subject: Re: New proposed DRM interface design
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mharris@redhat.com
In-Reply-To: <413D74A5.3070002@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040904102914.B13149@infradead.org>
	 <4139FEB4.3080303@tungstengraphics.com>
	 <9e473391040904110354ba2593@mail.gmail.com>
	 <1094386050.1081.33.camel@localhost.localdomain>
	 <9e47339104090508052850b649@mail.gmail.com>
	 <1094393713.1264.7.camel@localhost.localdomain>
	 <9e473391040905083326707923@mail.gmail.com>
	 <1094395462.1271.12.camel@localhost.localdomain>
	 <9e47339104090509056e54866e@mail.gmail.com> <413D74A5.3070002@hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Sep 2004 10:43:17 +0200, Helge Hafting <helge.hafting@hist.no> wrote:
> Jon Smirl wrote:
> >I would also like to fix things so that we can have two logged in
> >users, one on each head. This isn't going to work if one them uses
> >fbdev and keeps swithing the chip to 2D mode while the other user is
> >in 3D mode. The chip needs to stay in 3D mode with the CP running.
> >
> Yes!  I use the ruby patch and have two users logged in on the
> two heads of a G550.  It works fine - as long as no mode
> change is attempted.  And only one user can use 3D (or even 2D),
> the other is stuck with a unaccelerated framebuffer.

There is nothing in the hardware preventing both users from having 3D
displays. This is a problem in the way fbdev and DRM are designed. I
would like to work towards fixing this.

-- 
Jon Smirl
jonsmirl@gmail.com

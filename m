Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVAMFvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVAMFvl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 00:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVAMFvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 00:51:41 -0500
Received: from orb.pobox.com ([207.8.226.5]:5812 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261163AbVAMFvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 00:51:39 -0500
Date: Wed, 12 Jan 2005 21:51:30 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113055130.GF4378@ip68-4-98-123.oc.oc.cox.net>
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 08:48:57PM -0800, Linus Torvalds wrote:
> Quite frankly, nobody should ever depend on the kernel having zero holes.  
> We do our best, but if you want real security, you should have other
> shields in place. exec-shield is one. So is using a compiler that puts

That reminds me...

What are the chances of exec-shield making it into mainline anytime
in the near future? It's the *big* feature that has me preferring
Red Hat/Fedora vendor kernels over mainline kernels, even on non-Red
Hat/Fedora distributions. (I know that parts of exec-shield are already in
mainline, but I'm wondering about the parts that haven't been merged yet.)

-Barry K. Nathan <barryn@pobox.com>


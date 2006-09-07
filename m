Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751685AbWIGLPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbWIGLPe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 07:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbWIGLPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 07:15:33 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:33001 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751685AbWIGLPc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 07:15:32 -0400
Subject: Re: [stable] [PATCH] IA64,sparc: local DoS with corrupted ELFs
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, Fernando Vazquez <fernando@oss.ntt.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, "David S. Miller" <davem@davemloft.net>,
       devel@openvz.org, xemul@openvz.org
In-Reply-To: <20060906192511.GA14579@kroah.com>
References: <44FC193C.4080205@openvz.org>
	 <Pine.LNX.4.64.0609061120430.27779@g5.osdl.org>
	 <20060906182733.GJ2558@parisc-linux.org> <20060906184509.GA15942@kroah.com>
	 <20060906191215.GK2558@parisc-linux.org> <20060906192511.GA14579@kroah.com>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 15:11:42 +0200
Message-Id: <1157634702.30159.89.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > > Yes, but the -stable developers don't build for those arches, that's why
> > > it was missed here.
> > 
> > What's the easiest way to get coverage here?  Sending a parisc
> > workstation or server to someone?  Giving accounts to some/all of the
> > stable team?  Finding someone who cares about parisc to join the stable
> > team?
> 
> How about: Someone from that arch trying out the -stable release
> canidates to make sure it doesn't break anything on their arches /
> favorite machine?

this won't work for security hot-fixes, because you basically don't do a
release candidate for them. We should think about this, too.

Regards

Marcel



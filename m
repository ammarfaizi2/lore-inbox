Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbTJQQsJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 12:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbTJQQsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 12:48:09 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:10252 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263555AbTJQQsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 12:48:06 -0400
Date: Fri, 17 Oct 2003 17:48:02 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Sven Luther <sven.luther@wanadoo.fr>
cc: "Carlo E. Prelz" <fluido@fluido.as>,
       <linux-fbdev-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
In-Reply-To: <20031016092906.GA6602@iliana>
Message-ID: <Pine.LNX.4.44.0310171747230.966-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, Oct 16, 2003 at 11:19:18AM +0200, Carlo E. Prelz wrote:
> >  /* Radeon RV280 (9200) */
> >  #define PCI_DEVICE_ID_ATI_RADEON_Y_    0x5960
> > +#define PCI_DEVICE_ID_ATI_RADEON_Yz    0x5964
> >  /* Radeon R300 (9500) */
> >  #define PCI_DEVICE_ID_ATI_RADEON_AD    0x4144
> >  /* Radeon R300 (9700) */
> > 
> > (I did not know how to call it. _Yz did not exist, so I grabbed it. Is
> > there any logic in these codes?)
> 
> You use the ascii code of the id :
> 
>   0x41 -> A, 0x44 -> D thus 0x4144 -> AD.
> 
> So, the 0x5964 must be Yd.

So that is the logic to it?



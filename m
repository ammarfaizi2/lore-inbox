Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272414AbTHOXnq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 19:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272426AbTHOXnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 19:43:46 -0400
Received: from AMarseille-201-1-4-67.w217-128.abo.wanadoo.fr ([217.128.74.67]:10794
	"EHLO gaston") by vger.kernel.org with ESMTP id S272414AbTHOXnp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 19:43:45 -0400
Subject: Re: FBDEV updates.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Otto Solares <solca@guug.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0308152319570.30952-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0308152319570.30952-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060990952.881.89.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Aug 2003 01:42:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Will do. I like to also handle Video mode change. Even userland will like 
> to know when a mode change happened. For userland a signal can be sent. 
> This would be useful for someone in X that runs fbset in a Xterm. This 
> hoses the X server. It would be nice if the X server would see the signal 
> change and adapt to it. Fbset could in theory be used again to change a VC 
> size. Yuck!!!! But it is what people want.

And for good reasons as we still have to deal with cases
where neither the driver nor modedb knows what the monitor supports...

Ben.


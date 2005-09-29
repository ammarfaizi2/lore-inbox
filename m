Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbVI2XZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbVI2XZM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVI2XZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:25:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23949 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751358AbVI2XZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:25:10 -0400
Date: Thu, 29 Sep 2005 16:25:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: michal.k.k.piotrowski@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm2
Message-Id: <20050929162507.3efb8b1a.akpm@osdl.org>
In-Reply-To: <433C765D.9020205@gmail.com>
References: <20050929143732.59d22569.akpm@osdl.org>
	<6bffcb0e05092915472f8589eb@mail.gmail.com>
	<433C765D.9020205@gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antonino A. Daplas" <adaplas@gmail.com> wrote:
>
> Michal Piotrowski wrote:
> > Hi,
> > 
> > On 29/09/05, Andrew Morton <akpm@osdl.org> wrote:
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm2/
> >>
> >> (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc2-mm2.gz)
> > 
> > VESA VGA graphics support doesn't work with nvidia card (black
> > screen). (I know there is nvidia frame buffer support, but VESA VGA
> > works for me on current git).
> > 
> > #
> > # Console display driver support
> > #
> > CONFIG_VGA_CONSOLE=y
> > CONFIG_DUMMY_CONSOLE=y
> > # CONFIG_FRAMEBUFFER_CONSOLE is not set
> 
> Set this to y.
> 

Was this a slipup by Michal, or did we do something to fool `make oldconfig'?

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274235AbRIXXTS>; Mon, 24 Sep 2001 19:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274236AbRIXXTI>; Mon, 24 Sep 2001 19:19:08 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61197 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274235AbRIXXS4>; Mon, 24 Sep 2001 19:18:56 -0400
Subject: Re: 2D graphics: KGI, GGI, fbdev, DRI, svgalib, oh my!!!
To: jeffm@boxybutgood.com (Jeff Meininger)
Date: Tue, 25 Sep 2001 00:24:28 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109241617240.3945-100000@mangonel.localdomain> from "Jeff Meininger" at Sep 24, 2001 04:49:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15lf5Q-00043m-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If my ultimate goal is a maximum level of hardware acceleration,
> especially for scrolling and alpha-blending, which linux graphics
> interface would be the best choice for my needs?

OpenGL is probably what you want to be using for that kind of stuff. For
simple traditional 2D stuff the SDL library might also be interesting.

Both SDL and OpenGL are cross platform interfaces which helps no end. For
2D opengl usage take a look at chromium

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbSLZTji>; Thu, 26 Dec 2002 14:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbSLZTji>; Thu, 26 Dec 2002 14:39:38 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:41997 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263544AbSLZTjh>; Thu, 26 Dec 2002 14:39:37 -0500
Date: Thu, 26 Dec 2002 19:47:52 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Jurriaan <thunder7@xs4all.nl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: also frustrated with the framebuffer and your matrox-card in
 2.5.53? hack/patch available!
In-Reply-To: <20021226142032.GA7852@middle.of.nowhere>
Message-ID: <Pine.LNX.4.44.0212261942290.5748-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It's rather annoying that in a feature-freeze period a change goes in
> that cripples the one framebuffer with the best speed and features -
> the matrox framebuffer. 

Because a driver has over 10,000 lines of code does not mean it is a 
quality driver.

> The author mentioned it could be weeks or months
> before he would be able to get his matrox framebuffer working with the
> new framework, since its simple API doesn't fit the possibilities of the
> matrox framebuffer. Read more about it on the fbdev-users or
> fbdev-developers mailinglist on sourceforge.

Petr is expressing his political view. It has nothing to do with technical 
arguments. In fact I place a bet. I will port the matrox driver and it 
will have the same functionality as the previous driver except for text 
mode support. If I can't do it I will not only revert the changes but I 
will give Petr his wetdream. I will start inetergrating vt.c and 
vt_ioctl.c into each fbdev driver. Each fbdev driver will be its own 
console system. We will not longer need vt.c and vt_ioctl.c as each driver 
will have its own version intergated into the driver. Sound fair?


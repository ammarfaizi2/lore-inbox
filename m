Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSFNWxi>; Fri, 14 Jun 2002 18:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314680AbSFNWxh>; Fri, 14 Jun 2002 18:53:37 -0400
Received: from www.transvirtual.com ([206.14.214.140]:16652 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S314634AbSFNWxg>; Fri, 14 Jun 2002 18:53:36 -0400
Date: Fri, 14 Jun 2002 15:53:05 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Denis Oliver Kropp <dok@directfb.org>
cc: Russell King <rmk@arm.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5.21] CyberPro 32bit support and other fixes
In-Reply-To: <20020613092323.GA2384@skunk.convergence.de>
Message-ID: <Pine.LNX.4.44.0206141550000.21575-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why is the pseudo palette used anyway?

Its a fast way for the console to grab the proper console index color to
draw to the framebuffer. Otherwise we have to regenerate the color all the
time. Plus it is always endian code for us :-)

> There's no speed benefit and
> applications running in true/direct color would look wrong.

For userland no but for the kernel we do have a benifiet.


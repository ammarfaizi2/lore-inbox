Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316544AbSHOEcs>; Thu, 15 Aug 2002 00:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSHOEcs>; Thu, 15 Aug 2002 00:32:48 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:23243 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S316544AbSHOEcs>; Thu, 15 Aug 2002 00:32:48 -0400
Date: Wed, 14 Aug 2002 21:30:54 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [PATCH] broken cfb* support in the 2.5.31-bk
In-Reply-To: <20020814192327.GD37217@ppc.vc.cvut.cz>
Message-ID: <Pine.LNX.4.33.0208142128260.7482-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi Linus, hello others,
>   please apply this.
>
> line_length, type and visual moved from display struct to the fb_info's fix
> structure during last fbdev updates. Unfortunately generic code was not updated
> together, so now every fbdev driver is broken.

That was done to push people to port there drivers to the new api. I
applied the patch to the Bk repository but expect more breakage.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSHOK1A>; Thu, 15 Aug 2002 06:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSHOK1A>; Thu, 15 Aug 2002 06:27:00 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:23307 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S316673AbSHOK1A>;
	Thu, 15 Aug 2002 06:27:00 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: James Simmons <jsimmons@infradead.org>
Date: Thu, 15 Aug 2002 12:30:11 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [Linux-fbdev-devel] [PATCH] broken cfb* support in the 
CC: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <linux-fbdev-devel@lists.sourceforge.net>
X-mailer: Pegasus Mail v3.50
Message-ID: <212B36E116D@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Aug 02 at 21:30, James Simmons wrote:
> > Hi Linus, hello others,
> >   please apply this.
> >
> > line_length, type and visual moved from display struct to the fb_info's fix
> > structure during last fbdev updates. Unfortunately generic code was not updated
> > together, so now every fbdev driver is broken.
> 
> That was done to push people to port there drivers to the new api. I
> applied the patch to the Bk repository but expect more breakage.

Which new API? If you are going to remove logo and unaccelerated fbcon-cfb*,
then remove them completely. If you are not going to remove unaccelerated
fbcon-cfb*, then there is no reason for breaking them.

I'm not going to remove unaccelerated code from the matroxfb. Never.
                                                     Petr Vandrovec
                                                     vandrove@vc.cvut.cz

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267251AbUIJIgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267251AbUIJIgt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 04:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267303AbUIJIgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 04:36:48 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:38276 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S267251AbUIJIeO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 04:34:14 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
Date: Fri, 10 Sep 2004 16:35:25 +0800
User-Agent: KMail/1.5.4
Cc: Antonino Daplas <adaplas@pol.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <1094783022.2667.106.camel@gaston> <1094796002.14398.118.camel@gaston> <Pine.GSO.4.58.0409101004320.93@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0409101004320.93@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409101635.25738.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 September 2004 16:07, Geert Uytterhoeven wrote:
> On Fri, 10 Sep 2004, Benjamin Herrenschmidt wrote:
> > I submited a patch moving offb to the bottom of the Makefile to at
> > least restore normal drivers. For ofonly, a bit more hackish, but
>
> Just in case they aren't, vesafb and vga16fb should also be at the bottom,
> cfr. the old order in fbmem.c.
>

They are, with vfb at the very last.

> > what about failing register_framebuffer for anything but offb ?
>
> Humm, indeed hackerish...
>
> But the advantage of this is that we can finally exercise the failure path
> of many frame buffer device drivers in the wild ;-)
>

Assuming, as I've mentioned in another thread, that info->fix.name ==
to video=xxxfb.

Tony



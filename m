Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVCEUvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVCEUvA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 15:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVCEUut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 15:50:49 -0500
Received: from smtp-out.hotpop.com ([38.113.3.51]:33205 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261189AbVCEUtg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 15:49:36 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Adrian Bunk <bunk@stusta.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] [2.6 patch] make savagefb one module
Date: Sun, 6 Mar 2005 04:49:17 +0800
User-Agent: KMail/1.5.4
Cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       adaplas@pol.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20050301024118.GF4021@stusta.de> <Pine.LNX.4.62.0503041017000.22831@numbat.sonytel.be> <20050305011241.GO3327@stusta.de>
In-Reply-To: <20050305011241.GO3327@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503060449.24256.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 March 2005 09:12, Adrian Bunk wrote:
> On Fri, Mar 04, 2005 at 10:17:17AM +0100, Geert Uytterhoeven wrote:
> > On Fri, 4 Mar 2005, Adrian Bunk wrote:
> > > This patch links all selected files under drivers/video/savagefb/ into
> > > one module.
> > >
> > > This required a renaming of savagefb.c to savagefb_driver.c .
> > >
> > > As a side effect, the EXPORT_SYMBOL's in this directory are no longer
> > > required.
> > >
> > > ---
> > >
> > > Other names than savagefb_driver.c (e.g. savagefb_main.c) are easily
> > > possible - I do not claim being good at picking names...
> >
> > savagefb_core.c?
>
> Antonino, what's your opinion?

I'll take your patch as is.

Tony



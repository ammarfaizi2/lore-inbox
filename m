Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbVBBPuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbVBBPuQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 10:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVBBPuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 10:50:16 -0500
Received: from b.relay.invitel.net ([62.77.203.4]:55510 "EHLO
	b.relay.invitel.net") by vger.kernel.org with ESMTP id S262418AbVBBPuG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 10:50:06 -0500
Date: Wed, 2 Feb 2005 16:50:05 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Accelerated frame buffer functions
Message-ID: <20050202155005.GA19062@vega.lgb.hu>
Reply-To: lgb@lgb.hu
References: <20050202133108.GA2410@s> <Pine.LNX.4.61.0502020900080.16140@chaos.analogic.com> <20050202142155.GA2764@s>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050202142155.GA2764@s>
X-Operating-System: vega Linux 2.6.10-2-686 i686
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 03:21:55PM +0100, Haakon Riiser wrote:
> > X-Windows already does this.
> 
> Yeah, I thought the X11 fbdev driver supported acceleration, but not
> according to its manpage:
> 
>   fbdev is an Xorg driver for framebuffer devices.  This is a
>   non-accelerated driver [...]

Yepp, it would be cool, to move every low level graphical operation to the
 framebuffer devices ... So no more 'I would like to use framebuffer
console _AND_ X at the same time without disturbing each other' problem,
and also if X segfaults or such, consolse will not remain in unusable state.
Also a solid low level graphical operation layer should provide even 3D
acceleration for fbdev capable (but not X!) apps and of course for the
X server ... without conflicting each other :) DirectFB seems to be a good
idea anyway ...

- Gábor

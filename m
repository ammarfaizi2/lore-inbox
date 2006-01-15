Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751924AbWAOMz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbWAOMz5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 07:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbWAOMz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 07:55:57 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:52748 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751924AbWAOMz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 07:55:57 -0500
Date: Sun, 15 Jan 2006 13:55:47 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Thomas Fazekas <thomas.fazekas@gmail.com>, linux-kernel@vger.kernel.org,
       arch@archlinux.org
Subject: Re: Modify setterm color palette
Message-ID: <20060115125547.GM7142@w.ods.org>
References: <421547be0601150407v8e087afh55a9ee12ae27ac8e@mail.gmail.com> <Pine.LNX.4.61.0601151313360.4174@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601151313360.4174@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Sun, Jan 15, 2006 at 01:15:23PM +0100, Jan Engelhardt wrote:
> 
> >I've been looking in the kernel sources in the "console.c" and I think
> >spotted the
> >place where the colours are set but it seems to me that a more appropiate
> >place to do such things would be the terminfo db.
> >
> >Any hints ?
> 
> drivers/char/vt.c: default_red, default_grn, default_blu
> 
> You can also change them with `echo -en "\e]PXRRGGBB"`, where X is a hex 
> digit (range 0-F), and RGB are the components. Check console_codes(4) and 
> go figure. :)

Thanks for the tip, I was not aware of this !

> >I'm using radeonfb under Suse/amd64 if that makes any difference...
> 
> I am not sure if changing colors works with fb, try your best.

I can confirm that it works on matrox_fb at least !

> Jan Engelhardt

regards,
willy


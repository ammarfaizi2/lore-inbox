Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVGIVOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVGIVOV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 17:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVGIVOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 17:14:21 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:9188 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S261733AbVGIVOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 17:14:20 -0400
Date: Sat, 9 Jul 2005 23:14:34 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Bodo Eggert <7eggert@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Documentation mismatch in Documentation/kbuild/kconfig-language.txt
In-Reply-To: <20050709093657.GG28243@stusta.de>
Message-ID: <Pine.LNX.4.58.0507092309120.7783@be1.lrz>
References: <Pine.LNX.4.58.0507041639500.24224@be1.lrz> <20050708221756.GM3671@stusta.de>
 <Pine.LNX.4.58.0507090934510.4231@be1.lrz> <20050709093657.GG28243@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Jul 2005, Adrian Bunk wrote:
> On Sat, Jul 09, 2005 at 09:37:48AM +0200, Bodo Eggert wrote:

[menu dependencies "if" vs. "depends on"]

> > It should be, but either it's really applied to the config instead of the 
> > prompt (in which can also be added to the depends on list) or the 
> > menuconfig '/' function has bogus output.
> 
> config FUTEX
>         bool "Enable futex support" if EMBEDDED
>         default y
> 
> This option is always "y" if EMBEDDED=n.
> This option is uservisible if EMBEDDED=y.
> 
> I don't understand what's not working for you in this case.

I used make menuconfig for diagnosis, and it's output meges "depends on" 
with "if". Therefore I had to asume that the config logic does the same.
-- 
Top 100 things you don't want the sysadmin to say:
55. NO!  Not _that_ button!

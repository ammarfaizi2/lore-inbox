Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVCUSpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVCUSpw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 13:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVCUSpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 13:45:52 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:44967 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S261520AbVCUSpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 13:45:47 -0500
Date: Mon, 21 Mar 2005 19:50:33 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Andi Kleen <ak@muc.de>
Cc: Bodo Eggert <7eggert@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11.2][RFC] printk with anti-cluttering-feature
In-Reply-To: <m1is3l3v25.fsf@muc.de>
Message-ID: <Pine.LNX.4.58.0503211936380.7193@be1.lrz>
References: <Pine.LNX.4.58.0503200528520.2804@be1.lrz> <m1is3l3v25.fsf@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005, Andi Kleen wrote:
> Bodo Eggert <7eggert@gmx.de> writes:

> > atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
> >  (I'm using a keyboard switch and a IBM PS/2 keyboard)
> 
> This one should be just taken out. It is as far as I can figure out
> completely useless and happens on most machines.

This leaves one known user. Are there other places that might use this
feature? I asume yes, since I only fixed the message spamming my own log.

If someone gives me a pointer, I could fix those places before I submit 
the updated patch. A new function for just one user would look silly.

-- 
Top 100 things you don't want the sysadmin to say:
56. Sorry, we deleted that package last week...

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268053AbUJFFuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268053AbUJFFuO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 01:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268069AbUJFFuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 01:50:14 -0400
Received: from mail.dif.dk ([193.138.115.101]:65408 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S268053AbUJFFuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 01:50:08 -0400
Date: Wed, 6 Oct 2004 07:57:34 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Anthony DiSante <orders@nodivisions.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: KVM -> jumping mouse... still no solution?
In-Reply-To: <4163845C.9020900@nodivisions.com>
Message-ID: <Pine.LNX.4.61.0410060753590.2993@dragon.hygekrogen.localhost>
References: <4163845C.9020900@nodivisions.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004, Anthony DiSante wrote:

> you don't move it, but if you move it N/E/NE it's really slow and jerky, and
> if you move it S/W/SW even a hair, it slams down to the SW corner of the
> screen and acts like you hit all the mouse's buttons 50 times simultaneously.
> 
I've had similar problems with my mouse and KVM switch.

> The other day I came across this (kerneltrap.org/node/view/2199): "Use
> psmouse.proto=bare on the kernel command line, or proto=bare on the
> psmouse module command line."  But that makes the mouse's scroll-wheel not
> work.  (And this problem doesn't exist with some of the mouse drivers, but it
> does with IMPS/2, which is the only one I've ever been able to get the scroll
> wheel working with.)
> 
psmouse.proto=imps solves the problem for me (wheel works as well).
The funny thing is that I don't need to do anything like this when I boot 
a 2.4 kernel, only 2.6 kernels show this behaviour on my system.???

--
Jesper Juhl


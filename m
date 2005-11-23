Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030489AbVKWXKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030489AbVKWXKd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030490AbVKWXKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:10:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:15332 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030489AbVKWXKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:10:32 -0500
Subject: Re: [git pull 09/14] Uinput: add UI_SET_SWBIT ioctl
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1132786436.26560.339.camel@gaston>
References: <20051120063611.269343000.dtor_core@ameritech.net>
	 <20051120064420.389911000.dtor_core@ameritech.net>
	 <1132786436.26560.339.camel@gaston>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 10:06:42 +1100
Message-Id: <1132787202.26560.343.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-24 at 09:54 +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2005-11-20 at 01:36 -0500, Dmitry Torokhov wrote:
> > plain text document attachment (uinput-add-sw-ioctl.patch)
> > Input: uinput - add UI_SET_SWBIT ioctl
> > 
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> All these new ioctl's and no compat layer for 32 bits apps on 64 bits
> kernels ...
> 
> I'll send a patch later today for the current ones, but please, do it
> from day #1 next time :)

Ok, forget my promise, I won't do a compat layer for it today. Way too
much crap in there, read's of structs made of other structs & unions
etc... all of this would need compat versions etc... no time for that.

Couldn't you have designed that properly in the first place ?

Ben.



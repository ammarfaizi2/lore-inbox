Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbTLXMr1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 07:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbTLXMr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 07:47:27 -0500
Received: from [24.35.117.106] ([24.35.117.106]:29072 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263598AbTLXMr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 07:47:26 -0500
Date: Wed, 24 Dec 2003 07:47:19 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-mm1
In-Reply-To: <20031224033200.0763f2a2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0312240742490.31297@localhost.localdomain>
References: <20031224095921.GA8147@lsc.hu> <20031224033200.0763f2a2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Dec 2003, Andrew Morton wrote:

> > - I have a synaptics touchpad, which is detected correctly, but only
> >   works if I set psmouse_noext=1. Under vanilla 2.6.0 it still works this
> >   way, but with 2.6.0-mm1 it works only on the console, but not under
> >   XFree86. Strange, as gpm interprets the input and pipes thru gpmdata
> >   to XFree86 4.3.0. Any idea what broke this configuration?
> 
> Peter or Dmitry may be able to tell us.

On the other hand, the synaptics touchpad on my laptop works under 
2.6.0-mm1 without the need to use the above parameter.  I don't get the 
jitter I reported for vanilla 2.6.0 synaptics support, but I do get an 
occasional small mouse jump.  

Other than that, 2.6.0-mm1 appears to be working well on my Presario 
12XL325 laptop.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbTJAApb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 20:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbTJAApa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 20:45:30 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:37637 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261890AbTJAAp3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 20:45:29 -0400
Date: Wed, 1 Oct 2003 02:45:16 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Paul Symons <paul@affronted.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: atkbd.c not recognising key on logitech cordless keyboard
Message-ID: <20031001004516.GB1520@win.tue.nl>
References: <200309302200.31040.paul@affronted.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309302200.31040.paul@affronted.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 10:00:30PM +0100, Paul Symons wrote:

> Hi, I have a Logitech Cordless Desktop with those funny extra buttons at the 
> top. However, one particular button no longer works when running development 
> kernels (it worked in 2.4 kernels). The first development kernel I tested 
> with was 2.5.75; it hasn't worked from then up until 2.6.0-test6, which I am 
> running now.
> 
> The key in question is labelled "Messenger / SMS" and gives scancode e0 11.

> Sep 30 21:55:32 fastpc kernel: atkbd.c: Unknown key pressed (translated set 2, 
> code 0x11d, data 0x11, on isa0060/serio0).

I do not think that scancode was associated to a keycode in a vanilla
2.4 kernel. So, maybe you used setkeycodes(8) or used a patched kernel?

Patching also works today. The setkeycodes command is a bit broken these days.

Andries



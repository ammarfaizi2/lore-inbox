Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTJASib (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 14:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTJASia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 14:38:30 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:44561 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262120AbTJAShB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 14:37:01 -0400
Date: Wed, 1 Oct 2003 20:36:48 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Rob Landley <rob@landley.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Keyboard dead on bootup on -test6.
Message-ID: <20031001183648.GB1686@win.tue.nl>
References: <200309301632.01498.rob@landley.net> <20031001005214.GC1520@win.tue.nl> <200309302021.56614.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309302021.56614.rob@landley.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 08:21:56PM -0500, Rob Landley wrote:

> > > Sep 30 16:17:31 localhost kernel: atkbd.c: Unknown key pressed (raw set
> > > 0, code 0xfc, data 0xfc, on isa0060/serio1).

> > I suppose this is the kernel trying to set LEDs on the mouse,
> > and the mouse complains.

> There are no LED's anywhere near it.  So I'm not surprised it complains.
> But why does that kill my keyboard?

I can conjecture, but reading the facts is easier if you have a debug log
(#define DEBUG in i8042.c).

[In case you already sent one, point at the URL - I've seen so many recently
I lost track who reported what.]


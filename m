Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263616AbUE2Oav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263616AbUE2Oav (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 10:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbUE2Oau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 10:30:50 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:33041 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263616AbUE2Oar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 10:30:47 -0400
Date: Sat, 29 May 2004 16:30:43 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040529143043.GE5175@pclin040.win.tue.nl>
References: <20040525201616.GE6512@gucio> <20040528194136.GA5175@pclin040.win.tue.nl> <20040528214620.GA2352@gucio> <20040529132320.GC5175@pclin040.win.tue.nl> <20040529134614.GA6420@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040529134614.GA6420@ucw.cz>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: dmv.com: mailhost.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 03:46:14PM +0200, Vojtech Pavlik wrote:

> > Thus, showkeys -s gave a garbage answer.
> > 
> > Thanks for the report. It shows that resurrecting raw mode is even
> > more desirable than I thought at first.
> 
> What for?

As you know, the keyboard/mouse situation in 2.6 is unfortunate.

I get a steady stream with letters from people complaining about
the keyboard utilities under 2.6. How can I answer and tell them
what the problem is? I need facts - raw data, so that I can
trace the path of this raw data through the kernel.

That is my reason I want a raw mode. Often I have to ask them
to boot 2.4 first to get reality, so that one afterwards is
in a better position to understand the fake reality of 2.6.

But apart from such debugging use, there is also the more
direct use: in order to assign a keycode to an unusual key
one first asks for the scancode using scancode -s, and then
assigns the keycode using setkeycodes. If scancode -s lies,
this fails.

Andries


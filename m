Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263681AbTJ0XN6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 18:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263700AbTJ0XN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 18:13:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:2001 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263681AbTJ0XN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 18:13:57 -0500
Date: Mon, 27 Oct 2003 15:13:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Andi Kleen <ak@muc.de>, <vojtech@suse.cz>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PS/2 mouse rate setting
In-Reply-To: <20031027224728.GA10618@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0310271511480.1600-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Oct 2003, Andries Brouwer wrote:
> Ergo, there is no reason to have it a boot parameter.

I'd agree. I don't really see the point of setting rate/resolution at 
_all_. But we've done it in 2.5.x, and somebody may have a valid reason 
for it, so when disabling it by default, leaving the option to specialize 
is probably a good idea.

		Linus


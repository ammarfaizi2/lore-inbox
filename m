Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbTKLF3P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 00:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbTKLF3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 00:29:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:48843 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261724AbTKLF3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 00:29:15 -0500
Date: Tue, 11 Nov 2003 21:29:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Daniel Craig <dancraig@internode.on.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-bk16 ALi M5229 kernel boot error
In-Reply-To: <3FB1ADEC.80600@pobox.com>
Message-ID: <Pine.LNX.4.44.0311112127170.3288-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Nov 2003, Jeff Garzik wrote:
> 
> For a little bit of history, this 'if' test succeeds on Alpha.  We 
> return here on Alpha to avoid x86-specific stuff.

It's not x86-specific stuff, it's literally specific to the ISA bridge. 

And I'm pretty sure this horrid test was there at least partly for a 
Transmeta setup that had a non-ALI northbridge together with an ALI 
southbridge. The fact that it _also_ triggers on other machines may well 
be true, though.

			Linus


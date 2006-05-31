Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWEaUcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWEaUcw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWEaUcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:32:52 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:33721 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S964849AbWEaUct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:32:49 -0400
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       "Ondrej Zajicek" <santiago@mail.cz>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
In-Reply-To: <9e4733910605311257m19450bbai4c3ae6fdc7909a4@mail.gmail.com>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605272245.22320.dhazelton@enter.net> <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com> <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com> <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz> <20060530223513.GA32267@localhost.localdomain> <447CD367.5050606@gmail.com> <Pine.LNX.4.62.0605312033260.16745@pademelon.sonytel.be> <Pine.LNX.4.62.0605312033260.16745@pademelon.sonytel.be> <9e4733910605311257m19450bbai4c3ae6fdc7909a4@mail.gmail.com>
Date: Wed, 31 May 2006 21:32:42 +0100
Message-Id: <E1FlXMw-0002Md-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl <jonsmirl@gmail.com> wrote:

> Moving back to a vgafb with text mode support in fbcon would be one
> way to eliminate a few of the way too many graphics drivers. I don't
> see any real downside side to doing this, does any one else see any
> problems?

Just to check what you mean by "text mode" - is this vga mode 3, or 
a graphical vga mode with text drawn in it? vga16fb doesn't work on all 
hardware that vgacon works on, much to my continued misery.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org

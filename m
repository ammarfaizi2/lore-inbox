Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267364AbTA1QZx>; Tue, 28 Jan 2003 11:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267366AbTA1QZx>; Tue, 28 Jan 2003 11:25:53 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:38616 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267364AbTA1QZw>; Tue, 28 Jan 2003 11:25:52 -0500
Date: Tue, 28 Jan 2003 10:35:10 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Richard Henderson <rth@twiddle.net>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] new modversions implementation
In-Reply-To: <20030128083117.A15637@twiddle.net>
Message-ID: <Pine.LNX.4.44.0301281032540.1777-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2003, Richard Henderson wrote:

> On Tue, Jan 28, 2003 at 09:38:31PM +1100, Rusty Russell wrote:
> > 	But once again you are relying on link order to keep the crcs
> > section in the same order as the ksymtab section (although the ld
> > documentation says that's correct, I know RTH doesn't like it).
> 
> What gave you that idea?  Link order is a fine thing to rely on.

Cool, so I don't even need to start arguing ;) I was about to suggest 
adding a script like per_cpu_check to detect if the linker went crazy on 
us and complain, but now I hope rusty is convinced already.

--Kai



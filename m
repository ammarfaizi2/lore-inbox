Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267755AbTAIThP>; Thu, 9 Jan 2003 14:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267758AbTAIThP>; Thu, 9 Jan 2003 14:37:15 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:24851 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267755AbTAIThO>; Thu, 9 Jan 2003 14:37:14 -0500
Date: Thu, 9 Jan 2003 19:45:54 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: rotation.
In-Reply-To: <20030108104817.GA10165@iliana>
Message-ID: <Pine.LNX.4.44.0301091944540.5660-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Fbcon has the advantage that it'll work for all frame buffer devices.
> 
> But you could also provide driver hooks for the chips which have such a
> rotation feature included (don't know if such exist, but i suppose they
> do, or may in the future).

Hooks already exist in struct fb_ops.

> So, we also support fbcon for not left to righ locales ?

That will happen in the core console code.


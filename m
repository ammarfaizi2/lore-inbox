Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315862AbSGARK2>; Mon, 1 Jul 2002 13:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSGARK1>; Mon, 1 Jul 2002 13:10:27 -0400
Received: from www.transvirtual.com ([206.14.214.140]:35857 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S315862AbSGARK1>; Mon, 1 Jul 2002 13:10:27 -0400
Date: Mon, 1 Jul 2002 10:12:49 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>,
       <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] 2.5.24 matroxfb memory corruption
In-Reply-To: <20020630002834.GG25118@ppc.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0207011011260.21874-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> do_install_cmap(), he blindly changed also matroxfb, which happily
> uses fbcon.currcon == -1. This caused memory corruption because of
> memory before fb_display[] array was overwritten.
>   Default do_install_cmap() also installed invalid default color map
> in some matroxfb resolutions. Not all world have >= 4bpp.

Applied to BK tree.



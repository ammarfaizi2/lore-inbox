Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbTFOSOi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 14:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTFOSOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 14:14:38 -0400
Received: from colin2.muc.de ([193.149.48.15]:6405 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262498AbTFOSOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:14:37 -0400
Date: 15 Jun 2003 20:28:28 +0200
Message-ID: <20030615202827.55015@colin.muc.de>
Date: Sun, 15 Jun 2003 20:28:27 +0200
From: Andi Kleen <ak@colin.muc.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix undefined/miscompiled construct in kernel parameters
References: <m3of0zdzuz.fsf@averell.firstfloor.org> <Pine.LNX.4.44.0306151021440.8088-100000@home.transmeta.com> <20030615193256.29257@colin.muc.de> <Pine.LNX.4.44.0306151943100.12110-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
In-Reply-To: <Pine.LNX.4.44.0306151943100.12110-100000@serv>; from Roman Zippel on Sun, Jun 15, 2003 at 07:48:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 07:48:56PM +0200, Roman Zippel wrote:
> Hi,
> 
> On 15 Jun 2003, Andi Kleen wrote:
> 
> > I tend to agree, feel free to flame them. But it doesn't help me right now 
> > when I want to get a booting kernel. Could you merge that change or if you 
> > prefer I can rewrite it to anonymous asm (but it will be probably more ugly). 
> > I just need some workaround.
> 
> Does the patch below work better?

Nope, generates exactly the same code.

-Andi

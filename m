Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282890AbRLMNa3>; Thu, 13 Dec 2001 08:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282947AbRLMNaU>; Thu, 13 Dec 2001 08:30:20 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:26563 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S282890AbRLMNaF>;
	Thu, 13 Dec 2001 08:30:05 -0500
Date: Thu, 13 Dec 2001 14:29:51 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: David Woodhouse <dwmw2@infradead.org>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: FBdev remains in unusable state 
In-Reply-To: <8895.1008243321@redhat.com>
Message-ID: <Pine.GSO.4.30.0112131429040.16242-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2001, David Woodhouse wrote:

>
> VANDROVE@vc.cvut.cz said:
> > Documentation/fb/vesafb.txt, X11 paragraph, last sentence:
> > -------8<-----
> > The X-Server must restore the video mode correctly, else you end up
> > with a broken console (and vesafb cannot do anything about this).
> > -------8<-----
>
> This isn't strictly true. We could just call the VESA BIOS to set it up
> again for us. The 'vesa' XFree86 driver manages to do this perfectly well
> from userspace, even.

Then why not include this set up code into vesafb?

-- 
Balazs Pozsar


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbSJILcD>; Wed, 9 Oct 2002 07:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261541AbSJILcC>; Wed, 9 Oct 2002 07:32:02 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:42880 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261550AbSJILcC>;
	Wed, 9 Oct 2002 07:32:02 -0400
Date: Wed, 9 Oct 2002 13:37:38 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Input - Only try to enable extra keys if user requested it [2/3]
Message-ID: <20021009133738.D815@ucw.cz>
References: <20021009101256.A10748@ucw.cz> <20021009130035.A367@ucw.cz> <20021009130123.B367@ucw.cz> <1034163931.1323.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1034163931.1323.3.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Oct 09, 2002 at 12:45:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 12:45:31PM +0100, Alan Cox wrote:

> On Wed, 2002-10-09 at 12:01, Vojtech Pavlik wrote:
> >   Don't try to enable extra keys on IBM/Chicony keyboards as this upsets
> >   several notebook keyboards. Until we find a better solution how to detect
> >   who are we talking to, we rely on the kernel command line. Use
> >   atkbd_set=4 to gain access to the extra keys.
> 
> Surely this also wants a runtime option, or do you assume its fixable
> somehow ?

I hope I'll be able to find a way how to distinguish between the
notebook keyboards and the extra-key keyboards.

I'm developing a keyboard/mouse analyzer module. ;)

On the other hand, 2.4 doesn't support this feature at all.

So rebooting or reloading the atkbd module should suffice for now.

-- 
Vojtech Pavlik
SuSE Labs

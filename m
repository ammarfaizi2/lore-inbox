Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271116AbTHLU47 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 16:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271117AbTHLU47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 16:56:59 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:53140 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S271116AbTHLU45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 16:56:57 -0400
Date: Tue, 12 Aug 2003 22:56:42 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Stefan Reinauer <stepan@suse.de>, linux-kernel@vger.kernel.org,
       Andries Brouwer <aebr@win.tue.nl>
Subject: Re: 2.6.0-test2 has i8042 mux problems
Message-ID: <20030812205642.GD23011@ucw.cz>
References: <Pine.LNX.4.53.0307271906020.18444@twinlark.arctic.org> <20030728142952.GA1341@suse.de> <Pine.LNX.4.53.0307280927590.18444@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307280927590.18444@twinlark.arctic.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 09:38:15AM -0700, dean gaudet wrote:
> On Mon, 28 Jul 2003, Stefan Reinauer wrote:
> 
> > * dean gaudet <dean-list-linux-kernel@arctic.org> [030728 04:13]:
> > > the southbridge in this system is the ali1563.  if it helps i can supply a
> > > complete trace of in/out on ports 0x60 and 0x64.
> >
> > I can confirm this. I have an Amilo A laptop with the following sb:
> > 00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
> >
> > without "i8042_nomux" the keyboard is recognized fine, but no mouse is
> > found on the mux. With the option everything works fine.
> 
> that's slightly different than what i get without i8042_nomux, and a
> keyboard & mouse plugged in, the system crashes and burns badly during
> boot.  without the keyboard and mouse it boots fine.
> 
> with i8042_nomux it's a lot happier.
> 
> my system is a test board for a new processor with the ali1563 -- which is
> a newer hypertransport variant of the 1533/1535.  i'm not sure yet if
> there are production boards with the 1563.  but it's nice to know it
> happens with your 1533 as well.

Hmm, I think I may have a similar bridge around ... I'll try.

> andries -- i'll send you a copy of the in/out traffic (it's a bit large
> for posting).
> 
> -dean
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

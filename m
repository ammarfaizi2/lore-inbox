Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261968AbTCZTNq>; Wed, 26 Mar 2003 14:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261970AbTCZTNq>; Wed, 26 Mar 2003 14:13:46 -0500
Received: from delphin.mathe.tu-freiberg.de ([139.20.24.12]:48936 "EHLO
	delphin.mathe.tu-freiberg.de") by vger.kernel.org with ESMTP
	id <S261968AbTCZTNR>; Wed, 26 Mar 2003 14:13:17 -0500
From: Michael Dreher <dreher@math.tu-freiberg.de>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: 2.5.66 double display
Date: Wed, 26 Mar 2003 20:26:54 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0303261836230.18664-100000@phoenix.infradead.org> <200303262012.28504.dreher@math.tu-freiberg.de>
In-Reply-To: <200303262012.28504.dreher@math.tu-freiberg.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303262026.54515.dreher@math.tu-freiberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I tried 2.5.66 now, and X is unusable. Everything is displayed
> > > twice. There is a vertical split in the middle, and the right half
> > > is identical to the left half. For instance, I have two half
> > > login prompts of kdm. I attach my .config.
> >
> > You have VESA framebuffer AND the ATI 128 driver enabled. Turn one
> > of them off.
>
> Doesnt help. .config attached.

But the other way around is OK. Now I have

CONFIG_FB=y
....
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
...
# CONFIG_FB_ATY128 is not set
...

and it works. Switch VESA and ATY128, and you have two displays on 
one monitor :-)



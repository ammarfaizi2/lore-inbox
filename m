Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262764AbSJGU2Z>; Mon, 7 Oct 2002 16:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262775AbSJGU1F>; Mon, 7 Oct 2002 16:27:05 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27899 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262764AbSJGU0m>; Mon, 7 Oct 2002 16:26:42 -0400
Date: Mon, 7 Oct 2002 22:32:13 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Vojtech Pavlik <vojtech@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: PC speaker dead in 2.5.40?
In-Reply-To: <20021007211427.A833@ucw.cz>
Message-ID: <Pine.NEB.4.44.0210072225320.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, Vojtech Pavlik wrote:

> On Mon, Oct 07, 2002 at 03:08:57AM -0400, Joseph Fannin wrote:
>...
> >     There's a good technical reason why the speaker is an input
> >     device, but hiding it in the menus is *bad*.
>
> Send me a patch that fixes this - if you know how.

IMHO the problem istn't to make a patch, it's more a "policy" question:
The problem is that from the point of view of a _user_ it's quite
surprising to see the speaker support at the input devices - and if the
speaker doesn't work you wouldn't search for an option under "Input device
support". From a programmers point of view "Input device support" might be
the best place but it will produce much confusion among many users. Is it
perhaps possible to move the speaker support to "Character devices"?

TIA
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265264AbRFUWWp>; Thu, 21 Jun 2001 18:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265263AbRFUWWf>; Thu, 21 Jun 2001 18:22:35 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:62453
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S265264AbRFUWW1>; Thu, 21 Jun 2001 18:22:27 -0400
Date: Thu, 21 Jun 2001 18:22:22 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: <nico@xanadu.home>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: CML2 <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: Missing help entries in 2.4.6pre5
In-Reply-To: <20010621154934.A6582@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0106211812560.30096-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Jun 2001, Eric S. Raymond wrote:

> The following configuration symbols in 2.4.6pre5 do not have
> Congfgure.help entries,:
[...]
> CONFIG_XSCALE_IQ80310

1- This symbol is mine;
2- It is part of 2.4.6-pre5 only as a dependency argument, with no
   point where a value is actually assigned to it;
3- It is likely to be different when the actual question for which the
   user need an help text is merged into the mainline kernel.

So you can safely ignore it for now.

Maybe it could be a good thing for your tool to ignore missing help text for
symbols that don't get enabled interactively by the user?


Nicolas


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313175AbSDOTHV>; Mon, 15 Apr 2002 15:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313179AbSDOTHU>; Mon, 15 Apr 2002 15:07:20 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:32014 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S313175AbSDOTHT>; Mon, 15 Apr 2002 15:07:19 -0400
Date: Mon, 15 Apr 2002 21:07:07 +0200 (CEST)
From: tomas szepe <kala@pinerecords.com>
To: James Simmons <jsimmons@transvirtual.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 keyboard problem
In-Reply-To: <Pine.LNX.4.10.10204151202400.1204-100000@www.transvirtual.com>
Message-ID: <Pine.LNX.4.44.0204152105220.27809-100000@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > an excerpt from the 2.5.8 .config in question:
> > .
> > .
> > CONFIG_INPUT=y
> > CONFIG_INPUT_KEYBDEV=y
> > CONFIG_INPUT_MOUSEDEV=y
> > .
> > .
> > CONFIG_SERIO=y
> > CONFIG_SERIO_SERPORT=y
>
> Wrong config for DJ tree. Here is what you need for PS/2 input keyboard
> support.
>
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_I8042_REG_BASE=60
> CONFIG_I8042_KBD_IRQ=1
> CONFIG_I8042_AUX_IRQ=12
>
> Also don't forget
>
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
>
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y


Yes, I'm aware, maybe I should have included the -dj .config as well.
Same results I'm afraid.

T.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270283AbTG1QXI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 12:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270291AbTG1QXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 12:23:08 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:45749 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S270283AbTG1QXG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 12:23:06 -0400
Date: Mon, 28 Jul 2003 09:38:15 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Stefan Reinauer <stepan@suse.de>
cc: linux-kernel@vger.kernel.org, Andries Brouwer <aebr@win.tue.nl>
Subject: Re: 2.6.0-test2 has i8042 mux problems
In-Reply-To: <20030728142952.GA1341@suse.de>
Message-ID: <Pine.LNX.4.53.0307280927590.18444@twinlark.arctic.org>
References: <Pine.LNX.4.53.0307271906020.18444@twinlark.arctic.org>
 <20030728142952.GA1341@suse.de>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003, Stefan Reinauer wrote:

> * dean gaudet <dean-list-linux-kernel@arctic.org> [030728 04:13]:
> > the southbridge in this system is the ali1563.  if it helps i can supply a
> > complete trace of in/out on ports 0x60 and 0x64.
>
> I can confirm this. I have an Amilo A laptop with the following sb:
> 00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
>
> without "i8042_nomux" the keyboard is recognized fine, but no mouse is
> found on the mux. With the option everything works fine.

that's slightly different than what i get without i8042_nomux, and a
keyboard & mouse plugged in, the system crashes and burns badly during
boot.  without the keyboard and mouse it boots fine.

with i8042_nomux it's a lot happier.

my system is a test board for a new processor with the ali1563 -- which is
a newer hypertransport variant of the 1533/1535.  i'm not sure yet if
there are production boards with the 1563.  but it's nice to know it
happens with your 1533 as well.

andries -- i'll send you a copy of the in/out traffic (it's a bit large
for posting).

-dean

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267029AbTAOUhf>; Wed, 15 Jan 2003 15:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267057AbTAOUhf>; Wed, 15 Jan 2003 15:37:35 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:37644 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267029AbTAOUhd>; Wed, 15 Jan 2003 15:37:33 -0500
Message-ID: <3E25B6ED.9594108A@linux-m68k.org>
Date: Wed, 15 Jan 2003 20:30:53 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: display bug in "make xconfig" in 2.5.58
References: <Pine.LNX.4.44.0301150638170.24623-100000@dell>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Robert P. J. Day" wrote:

>   "make xconfig" will not display simple config entries at
> the top menu level.
> 
>   granted, at the moment, there *are* none of these, but if
> you examine arch/i386/Kconfig, it's clear that such things are
> at least possible -- X86, MMU, SWAP and so on.  (i deduce that,
> if a config entry has no label on its type attribute, it is
> not to be displayed, right?)

It's displayed, just push the back button until you get to the root.
Soon it should be possible to turn such entries (automatically) into
menuconfig entries, so they are displayed in the menu window.
BTW label is maybe the wrong word, it's a user prompt. If there is none,
it can't be displayed of course.

bye, Roman



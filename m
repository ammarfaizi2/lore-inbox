Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311320AbSEEOkC>; Sun, 5 May 2002 10:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311564AbSEEOkB>; Sun, 5 May 2002 10:40:01 -0400
Received: from air-2.osdl.org ([65.201.151.6]:9484 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S311320AbSEEOkB>;
	Sun, 5 May 2002 10:40:01 -0400
Date: Sun, 5 May 2002 07:39:30 -0700 (PDT)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@osdlab.pdx.osdl.net>
To: Tomas Szepe <szepe@pinerecords.com>
cc: "J.P. Morris" <jpm@it-he.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.x keyboard oddities
In-Reply-To: <20020505124704.GC4990@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.33.0205050737160.5576-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 May 2002, Tomas Szepe wrote:

| > [J.P. Morris <jpm@it-he.org>]
| >
| > The keyboard is a bog-standard AT 102 keyboard, attached through a
| > AT/PS2 converter to an ABIT KT133 ATX motherboard.. no USB stuff.
| > Keyboard is turned on in the input devices option in kernel config.
| > But it's utterly dead: even ALT-SYSRQ-B.  Is this normal?
|
| 1) Try booting with 'acpi=off'. It's broken for a number of systems
| (does precisely what you've described) and no official update is
| available as of yet. Alternatively, you can try to apply the most
| recent ACPI patch from [1].
|
| 2) Make sure you've enabled core input support and userland keyboard
| interface (CONFIG_INPUT, CONFIG_INPUT_KEYBDEV).

Under "Input device support", you should also enable
CONFIG_SERIO (Serial I/O support).

-- 
~Randy


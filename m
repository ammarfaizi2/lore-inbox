Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267228AbTAFV7h>; Mon, 6 Jan 2003 16:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267231AbTAFV7h>; Mon, 6 Jan 2003 16:59:37 -0500
Received: from air-2.osdl.org ([65.172.181.6]:14048 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267228AbTAFV7g>;
	Mon, 6 Jan 2003 16:59:36 -0500
Date: Mon, 6 Jan 2003 14:04:52 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Tom Rini <trini@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
       <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] configurable LOG_BUF_SIZE
In-Reply-To: <20030106212608.GQ5984@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.33L2.0301061359470.15416-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2003, Tomas Szepe wrote:

| > [rddunlap@osdl.org]
|
| > | |---------------------------------------------------------------------------
| > | | I'd probably be happier if the current one didn't even _ask_ the user (or|
| > | | only asked the user if kernel debugging is enabled), and just silently   |
| > | | defaulted to the normal values.                                          |
| > | |---------------------------------------------------------------------------
| >
| Randy,
|
| this looks correct to me.  Maybe using if/endif instead of the two
| 'depends on' would make the entry more explicit to the eye of a future
| beholder.

Hey Tomas,

Thanks for looking and giving me your comments.

if/endif would be useful there, especially if there was also an 'else'
available...

-- 
~Randy


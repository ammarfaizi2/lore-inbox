Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264766AbSLBRCj>; Mon, 2 Dec 2002 12:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264856AbSLBRCj>; Mon, 2 Dec 2002 12:02:39 -0500
Received: from air-2.osdl.org ([65.172.181.6]:9150 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264766AbSLBRCj>;
	Mon, 2 Dec 2002 12:02:39 -0500
Date: Mon, 2 Dec 2002 09:06:59 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]2.5.49-ac1 - more info on make error
In-Reply-To: <Pine.LNX.4.44.0211271540270.7715-201000@bilbo.tmr.com>
Message-ID: <Pine.LNX.4.33L2.0212020904210.27194-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2002, Bill Davidsen wrote:

| Knowing that modules are still broken, I changed all modules to be
| built-in and dropped all support for modules and retried the compile. I
| have disabled all but the features I really want to test on the new
| kernel, so I will not be reducing the features any more.

I haven't seen any replies or fixes for this.  Have you?

drivers/built-in.o(.data+0x31e14): undefined reference to `local symbols
in discarded section .exit.text'

Please visit http://www.kernelnewbies.org/scripts/ and download
the 'reference-discarded.pl' script, run it, and let us know where the
problem is.

-- 
~Randy


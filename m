Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267377AbTBQTWY>; Mon, 17 Feb 2003 14:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267384AbTBQTWY>; Mon, 17 Feb 2003 14:22:24 -0500
Received: from [81.2.122.30] ([81.2.122.30]:12551 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267377AbTBQTWY>;
	Mon, 17 Feb 2003 14:22:24 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302171932.h1HJWuiY011149@darkstar.example.net>
Subject: Re: [Linux-fbdev-devel] Re: New logo code [CONFIG OPTIONS]
To: adaplas@pol.net (Antonino Daplas)
Date: Mon, 17 Feb 2003 19:32:56 +0000 (GMT)
Cc: geert@linux-m68k.org, schottelius@wdt.de, thoffman@arnor.net,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <1045509708.1209.22.camel@localhost.localdomain> from "Antonino Daplas" at Feb 18, 2003 03:23:11 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So how about making the logo "float" above/obscure the text (ie,
> overlay)?  It's not difficult to implement since fbcon.c has "redraw"
> versions of fbcon_bmove() and fbcon_clear().  All that needs to be done
> is do a "scissors" test before an fb_imageblit().  

On the subject of the new logo code, would it be worth making it do
something, (change colour, move, or animate), during a console bell?

John.

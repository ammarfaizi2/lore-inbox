Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262889AbTDNJGK (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 05:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbTDNJGK (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 05:06:10 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:51658 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id S262889AbTDNJGI (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 05:06:08 -0400
Subject: Re: [PATCH] M68k IDE updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mackerras <paulus@samba.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0304141037410.28305-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0304141037410.28305-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050311961.5575.47.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Apr 2003 11:19:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-14 at 10:39, Geert Uytterhoeven wrote:

> Indeed. Ataris and Q40/Q60s have byteswapped IDE busses, but they expect
> on-disk data to be that way, for compatibility with e.g. TOS.

Some designers need to be shot...

What about optionally making fix_drive_id a platoform hook
(like it was, but with a reasonable default) to avoid clobbering
the common code with those #ifdefs ?

Ben.


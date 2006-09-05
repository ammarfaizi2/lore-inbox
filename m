Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965221AbWIEQok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965221AbWIEQok (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 12:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965222AbWIEQoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 12:44:39 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:59116 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S965221AbWIEQoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 12:44:38 -0400
Message-ID: <44FDA87B.5030902@s5r6.in-berlin.de>
Date: Tue, 05 Sep 2006 18:40:27 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, Takashi Iwai <tiwai@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org, pshou@realtek.com.tw
Subject: Re: CodingStyle
References: <20060831123706.GC3923@elf.ucw.cz> <s5h8xl52h52.wl%tiwai@suse.de> <20060831110436.995bdf93.rdunlap@xenotime.net> <20060902231509.GC13031@elf.ucw.cz> <20060902213046.dd9bf569.rdunlap@xenotime.net> <20060905080813.GE1958@elf.ucw.cz>
In-Reply-To: <20060905080813.GE1958@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> +Avoid extra spaces around ! operator, and do not place spaces around (s.

How about:

	Avoid extra spaces after the ! operator.
	Do not place spaces around parentheses.

Because "foo && !bar" is certainly OK.

Or more draconian for the former and less so for the latter rule:

	Do not put whitespace between any of the unary operators and
	their operand.

	It is usually unnecessary to have whitespace around parentheses
	as part of expressions, around brackets, or around the operators
	. and ->.

Rule 1 certainly applies likewise to ++, --, unary +, unary -, !, ~,
(typecast), unary *, unary &, sizeof.

Rule 2 applies to all of ( ), [ ], ., ->, except where line breaks and
indentation warrant whitespace, or where whitespace helps to read
expressions with more levels of braces. Although the latter should be
avoided anyway.
-- 
Stefan Richter
-=====-=-==- =--= --=-=
http://arcgraph.de/sr/

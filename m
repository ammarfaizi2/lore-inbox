Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbTC3Td0>; Sun, 30 Mar 2003 14:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261526AbTC3Tcr>; Sun, 30 Mar 2003 14:32:47 -0500
Received: from [195.39.17.254] ([195.39.17.254]:17924 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261528AbTC3Tby>;
	Sun, 30 Mar 2003 14:31:54 -0500
Date: Sun, 30 Mar 2003 19:23:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Filipau, Ihar" <ifilipau@sussdd.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: inw/outw performance
Message-ID: <20030330172306.GA6666@zaurus.ucw.cz>
References: <7A5D4FEED80CD61192F2001083FC1CF9065148@CHARLY>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7A5D4FEED80CD61192F2001083FC1CF9065148@CHARLY>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   And actually what I have found that on my development P3/1GHz system
>   every inw() takes more that 3us. I wasn't measuring outw() yet - but 
>   I do not expect its timing to be better.

inw/outw *is* slow. Memory map your
registers to speed it up.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...


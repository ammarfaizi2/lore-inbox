Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbTC3UVJ>; Sun, 30 Mar 2003 15:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbTC3UVJ>; Sun, 30 Mar 2003 15:21:09 -0500
Received: from mail.coastside.net ([207.213.212.6]:48048 "EHLO
	mail.coastside.net") by vger.kernel.org with ESMTP
	id <S261545AbTC3UVJ>; Sun, 30 Mar 2003 15:21:09 -0500
Mime-Version: 1.0
Message-Id: <p0521061cbaad04701a02@[207.213.214.37]>
In-Reply-To: <20030330172306.GA6666@zaurus.ucw.cz>
References: <7A5D4FEED80CD61192F2001083FC1CF9065148@CHARLY>
 <20030330172306.GA6666@zaurus.ucw.cz>
Date: Sun, 30 Mar 2003 12:32:06 -0800
To: Pavel Machek <pavel@ucw.cz>, "Filipau, Ihar" <ifilipau@sussdd.de>
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: inw/outw performance
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 7:23pm +0200 3/30/03, Pavel Machek wrote:
>  >   And actually what I have found that on my development P3/1GHz system
>>    every inw() takes more that 3us. I wasn't measuring outw() yet - but
>>    I do not expect its timing to be better.
>
>inw/outw *is* slow. Memory map your
>registers to speed it up.

Shouldn't be *that* slow, though, especially over PCI, unless the 
device in question is taking that long to respond--in which case 
memory mapping won't help.
-- 
/Jonathan Lundell.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262821AbVEOMiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbVEOMiS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 08:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbVEOMiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 08:38:18 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:22795 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262821AbVEOMiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 08:38:15 -0400
Date: Sun, 15 May 2005 14:25:23 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Maxim Berezovsky <berry@zarub.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux kernel v2.4.30 bugreport
Message-ID: <20050515122523.GE18600@alpha.home.local>
References: <200505151925.45767.berry@zarub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505151925.45767.berry@zarub.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2005 at 07:25:45PM +0700, Maxim Berezovsky wrote:
> [1] .c files containing "#include <linux/delay.h>" do not compiling with make
(...)
>  /lib/modules/2.4.30/build/include/linux/delay.h:57: error: parse error before 
> "do"

I suspect that your sources were corrupted (wrong patch, or something else),
because I don't have anything semblable in delay.h:57 :

57:static inline void msleep(unsigned long msecs)

And my system uses alsa-1.0.9-rc2 on top of 2.4.30 (modified though).

Regards,
Willy


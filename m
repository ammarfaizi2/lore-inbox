Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161204AbWGIWeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161204AbWGIWeA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 18:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161205AbWGIWeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 18:34:00 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18639 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161204AbWGIWd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 18:33:59 -0400
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
In-Reply-To: <20060709214439.GC2495@elf.ucw.cz>
References: <200607092058.k69KwVxN026427@harpo.it.uu.se>
	 <20060709214439.GC2495@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 09 Jul 2006 23:51:24 +0100
Message-Id: <1152485484.27368.100.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-07-09 am 23:44 +0200, ysgrifennodd Pavel Machek:
> Step 0: could we get some sanity checks into that loop? I'm pretty
> sure we'll face some TSCs going backwards... panic-king the box at
> that point is okay, but infinite loop is not...

If it goes backwards print a warning and carry on, a panic is as useless
for most users as a hang


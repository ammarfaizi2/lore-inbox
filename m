Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbUCXGEv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 01:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbUCXGEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 01:04:51 -0500
Received: from mail.tpgi.com.au ([203.12.160.100]:50880 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S262996AbUCXGEt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 01:04:49 -0500
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on
	the merge?]
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>
In-Reply-To: <200403232352.58066.dtor_core@ameritech.net>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au>
	 <200403231743.01642.dtor_core@ameritech.net>
	 <20040323233228.GK364@elf.ucw.cz>
	 <200403232352.58066.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1080104698.3014.4.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Wed, 24 Mar 2004 17:04:58 +1200
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-03-24 at 16:52, Dmitry Torokhov wrote:
> OK, so you have an error condition on your CD. Does it prevent suspend from
> completing? If not then I probably would not care about it till later when
> I see it in syslog... I remember that the one thing that Pat complained
> most often is your love for "panic"ing instead of trying to recover. In that
> case you understandably want as many preceding messages as possible left
> intact on the screen to diagnose the problem. If error recovery is ever done
> then some eye-candy probably won't hurt.

Suspend2 is capable of aborting (there are four panics for dire
situations; for the record swsusp.c has 14). I haven't tried to simulate
a media error, so I'm not perfectly sure it would abort okay, but it
wouldn't take too much to fix any issues.

Regards,

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.


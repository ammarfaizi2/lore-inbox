Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318710AbSHWIRQ>; Fri, 23 Aug 2002 04:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318711AbSHWIRP>; Fri, 23 Aug 2002 04:17:15 -0400
Received: from mail.iok.net ([62.249.129.22]:8978 "EHLO mars.iok.net")
	by vger.kernel.org with ESMTP id <S318710AbSHWIRP>;
	Fri, 23 Aug 2002 04:17:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Holger Schurig <h.schurig@mn-logistik.de>
To: Oskar Schirmer <os@emlix.com>
Subject: Re: cell-phone like keyboard driver anywhere?
Date: Fri, 23 Aug 2002 09:54:11 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200208210932.36132.h.schurig@mn-logistik.de> <E17i91I-0007nB-00@mailer.emlix.com>
In-Reply-To: <E17i91I-0007nB-00@mailer.emlix.com>
X-Archive: encrypt
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208230954.11132.h.schurig@mn-logistik.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IMO this should not be done by the kernel, but by the application.

One can read such stuff all the time ... but really this is not possible in a 
general way. You don't know in advance if one runs a ncurses, text-only, 
Qt/Embedded or X-Windows application.

> - it is easy for the application to check the timing of the
>   keys pressed and produce the desired characters instead [poll (2)].

Yes, it's easy to put that in a Qt/Embedded app, but what is when the app 
terminates?  You could not restart it via the keyboard, because the keyboard 
is dead. Yeah, it's cumbersome to restart it with a cell-like keyboard, but 
it's possible.



Anyway, I have to write it low-level, in the kernel. I just wondered if 
something like this already exists.


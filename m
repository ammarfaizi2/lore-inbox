Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbSLVUKH>; Sun, 22 Dec 2002 15:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265250AbSLVUKH>; Sun, 22 Dec 2002 15:10:07 -0500
Received: from [66.70.28.20] ([66.70.28.20]:27408 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S265246AbSLVUKG>; Sun, 22 Dec 2002 15:10:06 -0500
Date: Sun, 22 Dec 2002 21:12:23 +0100
From: DervishD <raul@pleyades.net>
To: Joshua Stewart <joshua.stewart@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A little explanation needed
Message-ID: <20021222201223.GC46@DervishD>
References: <1040535392.1518.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1040535392.1518.3.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Joshua :)

> In otherwords, what's the use of a do{X}while(0) "loop" instead of
> just X.  I'm not the world's best trained C programmer, so forgive
> me if I sound stupid.

    First, you do not sound stupid at all.

    Second. The do...while use in macros is to avoid the 'swallow
semicolon' effect ;)) In other words, it makes the entire macro
appear as a single statement. This avoids problems with 'else'
constructs with macros that expand to multiple statements.

    Someplace in the GNU cpp documentation you can find a far better
explanation of this effect and why the do...while helps (it makes the
macro a single statement...).

    Hope that helps :)
    Raúl

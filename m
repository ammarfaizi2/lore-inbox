Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbTBJWtJ>; Mon, 10 Feb 2003 17:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265400AbTBJWtJ>; Mon, 10 Feb 2003 17:49:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9485 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265368AbTBJWtJ>; Mon, 10 Feb 2003 17:49:09 -0500
Date: Mon, 10 Feb 2003 14:54:49 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: James Lamanna <james.lamanna@appliedminds.com>
cc: "'Stephen Hemminger'" <shemminger@osdl.org>,
       "'Maciej Soltysiak'" <solt@dns.toxicfilms.tv>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.5.60
In-Reply-To: <022401c2d14a$edc4d4c0$39140b0a@amthinking.net>
Message-ID: <Pine.LNX.4.44.0302101452080.2096-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Feb 2003, James Lamanna wrote:
>
> Looks like ->sig should be ->signal ??

Actually, it should be "sighand". And probably the thing shouldn't muck
around with signal internals at all, but right now the fix is to just 
replace all the "->sig" with "->sighand".

		Linus


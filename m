Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264663AbSKDM04>; Mon, 4 Nov 2002 07:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264664AbSKDM04>; Mon, 4 Nov 2002 07:26:56 -0500
Received: from [64.215.178.122] ([64.215.178.122]:25796 "HELO umaro.net")
	by vger.kernel.org with SMTP id <S264663AbSKDM0z>;
	Mon, 4 Nov 2002 07:26:55 -0500
Date: Mon, 4 Nov 2002 01:55:05 -0700
From: Rando Christensen <rando@babblica.net>
To: Hacksaw <hacksaw@hacksaw.org>
Cc: kaih@khms.westfalen.de, linux-kernel@vger.kernel.org
Subject: Re: Filesystem Capabilities in 2.6?
Message-Id: <20021104015505.7f5af5b1.rando@babblica.net>
In-Reply-To: <200211031050.gA3AoO2l008421@habitrail.home.fools-errant.com>
References: <8$A6Ivu1w-B@khms.westfalen.de>
	<200211031050.gA3AoO2l008421@habitrail.home.fools-errant.com>
Organization: Babblica
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.10; )
digiw00tX: v1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, 03 Nov 2002 05:50:24 -0500: Hacksaw (Hacksaw
<hacksaw@hacksaw.org>):

> I still find "mount --bind --capability=xx,yy /usr/bin/foo
> /usr/bin/foo" to be a strange syntax. It implies that one is mounting
> /usr/bin/foo over /usr/bin/foo, and adding the xx,yy capabilities.

This could be an argument _for_ doing it this way. As a sysadmin myself,
this makes a lot of sense to me, and being able to catch it by looking
in a 'mount' command is certainly a sweet proposal-- That way you can
constantly monitor anything that needs extra capabilities very simply.

And if mount supported an argument to ONLY show capability remounts,
there's a quick 'showcap' for you.

-- 
< There is a light that shines on the frontier >
<   And maybe someday, We're gonna be there.   >
<    Rando Christensen / rando@babblica.net    >

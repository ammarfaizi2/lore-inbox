Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264021AbSKDA6B>; Sun, 3 Nov 2002 19:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264210AbSKDA6B>; Sun, 3 Nov 2002 19:58:01 -0500
Received: from 1-064.ctame701-1.telepar.net.br ([200.181.137.64]:24961 "EHLO
	1-064.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S264021AbSKDA6B>; Sun, 3 Nov 2002 19:58:01 -0500
Date: Sun, 3 Nov 2002 23:04:23 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Pavel Machek <pavel@ucw.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
In-Reply-To: <20021103201105.GD27271@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44L.0211032303480.3411-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, Pavel Machek wrote:

> Suspend *needs* to touch all drivers.

Indeed, but ...

> I do stopping at high levels already

... does swsusp really need to duplicate the functionality of
the APM / ACPI layers ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>


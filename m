Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290151AbSAKW4U>; Fri, 11 Jan 2002 17:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290150AbSAKW4L>; Fri, 11 Jan 2002 17:56:11 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:56837 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S290151AbSAKWzy>;
	Fri, 11 Jan 2002 17:55:54 -0500
Date: Fri, 11 Jan 2002 22:19:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Paul.Clements@steeleye.com
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: nbd request too big
Message-ID: <20020111211933.GA371@elf.ucw.cz>
In-Reply-To: <20020107152423.78321.qmail@web14906.mail.yahoo.com> <Pine.LNX.4.10.10201071231440.5690-300000@clements.sc.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10201071231440.5690-300000@clements.sc.steeleye.com>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> If you're using the nbd-server from Pavel Machek's web site, you'll need to patch 
> nbd-server.c to make it work on ~2.4.3+ kernels. My patched version of nbd-server.c
> and cliserv.h are attached. The patched files make the server's request buffer be
> dynamically allocated, so any size request can be handled by the server. 
> The patched version also fixes some other outdated code (e.g., llseek -> lseek64).

You seem to be have used old version of nbd-server to do the
patch. Could you port it to new version (at nbd.sourceforge.net) and
mail me a patch?

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSGVBFv>; Sun, 21 Jul 2002 21:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315442AbSGVBFu>; Sun, 21 Jul 2002 21:05:50 -0400
Received: from rj.SGI.COM ([192.82.208.96]:34754 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S315439AbSGVBFu>;
	Sun, 21 Jul 2002 21:05:50 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5.25 net/core/Makefile 
In-reply-to: Your message of "Sun, 21 Jul 2002 18:56:24 EST."
             <Pine.LNX.4.44.0207211853130.16927-100000@chaos.physics.uiowa.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 Jul 2002 11:08:41 +1000
Message-ID: <25972.1027300121@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jul 2002 18:56:24 -0500 (CDT), 
Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:
>Makes sense to me. However, the CONFIG_ variables used in the Makefiles 
>are never "n", they are "y", "m" or undefined.
>
>In Config.in scripts you have to cater for "n" or "", and I've seen 
>various people on l-k carry this behavior into the Makefiles, but there 
>it's unnecessary for all I can tell.

It is required if you ever want autoconfigure to work, that
distinguishes between "" (undefined) and "n" (explicitly turned off).
Forward planning.


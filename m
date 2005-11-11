Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbVKKO01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVKKO01 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 09:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbVKKO01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 09:26:27 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:54919 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750751AbVKKO01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 09:26:27 -0500
Date: Fri, 11 Nov 2005 15:26:13 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Mickey Stein <yekkim@pacbell.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig: Makefile xconfig problem: qconf libs/cflags
 error
In-Reply-To: <43749921.2010603@pacbell.net>
Message-ID: <Pine.LNX.4.61.0511111519470.1609@scrub.home>
References: <43749921.2010603@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 11 Nov 2005, Mickey Stein wrote:

> The actual problem may be at another level, since I don't see a difference
> between the scripts/kconfig/Makefile & prior ones that work, but this patch
> seems in line with other targets that work and used the standard pkg-config
> --libs --cflags setup.

Interesting, I didn't know pkg-config supports qt, it's a good idea to use 
it if it's available, but I'd like to avoid to depend on it.
I'll look into it during the weekend.

bye, Roman

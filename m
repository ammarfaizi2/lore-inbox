Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266478AbTALNwT>; Sun, 12 Jan 2003 08:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266546AbTALNwT>; Sun, 12 Jan 2003 08:52:19 -0500
Received: from gate.perex.cz ([194.212.165.105]:25606 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S266478AbTALNwS>;
	Sun, 12 Jan 2003 08:52:18 -0500
Date: Sun, 12 Jan 2003 14:59:38 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Paul Rolland <rol@witbe.net>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Perex@suze.cz" <Perex@suze.cz>, "rol@as2917.net" <rol@as2917.net>
Subject: Re: [PATCH 2.5.56] Sound core not compiling without /proc support
In-Reply-To: <008f01c2ba32$3aab6f40$2101a8c0@witbe>
Message-ID: <Pine.LNX.4.33.0301121458540.611-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2003, Paul Rolland wrote:

> Hello,
> 
> Here is a quick patch to allow sound support to compile correctly
> when not using /proc support.

It's a bad fix. The null function declarations should go to 
include/sound/info.h.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


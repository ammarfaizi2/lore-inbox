Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317267AbSFRBDv>; Mon, 17 Jun 2002 21:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317270AbSFRBDs>; Mon, 17 Jun 2002 21:03:48 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:25323 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S317267AbSFRBDV>; Mon, 17 Jun 2002 21:03:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ghozlane Toumi <gtoumi@laposte.net>
To: Adrian Bunk <bunk@fs.tum.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       James Simmons <jsimmons@linux-fbdev.org>
Subject: Re: [patch] fix .text.exit compile error in sstfb.c
Date: Mon, 17 Jun 2002 21:02:10 -0400
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.NEB.4.44.0206161434070.11043-100000@mimas.fachschaften.tu-muenchen.de>
In-Reply-To: <Pine.NEB.4.44.0206161434070.11043-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020618010320.KVZC14183.tomts8-srv.bellnexxia.net@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 June 2002 08:37, Adrian Bunk wrote:
> Hi,

> The problem is that sstfb_remove is __devexit and calls sst_shutdown which
> is __exit. This causes the error above when CONFIG_HOTPLUG is set.
>

Sorry for the delay, 
Thank you for your patch, if Marcelo doesn't integrate it , I'll resend it to 
him ...

ghoz

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292601AbSCDRlv>; Mon, 4 Mar 2002 12:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292594AbSCDRkf>; Mon, 4 Mar 2002 12:40:35 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:64649 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S292589AbSCDRjj>;
	Mon, 4 Mar 2002 12:39:39 -0500
Date: Mon, 4 Mar 2002 18:39:31 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Gigabit Performance 2.4.19-preX - Excessive locks, calls, waits
In-Reply-To: <20020304001223.A29448@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.21.0203041830020.12740-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Have you tried the NAPI patch and the NAPI'fied e1000 driver?
I'm not sure how far the development has come but I know it improves
performance quite a bit versus the regular e1000 driver.

You'll find it here:
ftp://robur.slu.se/pub/Linux/net-development/NAPI/

kernel/napi-patch-ank is the NAPI patch, you need to change
the get_fast_time() call to do_gettimeofday() for it to compile.

e1000/ is the NAPI'fied e1000 driver, the latest release is from Jan 29
but there is a document that describes how you checkout the latest version
via cvs.

I've never tried the e1000 NAPI driver since I don't have one of these
boards but I use the tulip NAPI driver a lot here and it works great,
impressive performance.

I hope you get better performance.

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbSLHAqG>; Sat, 7 Dec 2002 19:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265019AbSLHAqG>; Sat, 7 Dec 2002 19:46:06 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:42421 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264984AbSLHAqG>; Sat, 7 Dec 2002 19:46:06 -0500
Subject: Re: status of HPT374 support in 2.4.20 and 2.5.50
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Jorg de Jong <jorg@dejong.info>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DF27AF9.7BA0D1B5@digeo.com>
References: <3DF26772.8040502@dejong.info> <3DF26DF4.F1692AFA@digeo.com>
	<3DF2759F.1090403@dejong.info>  <3DF27AF9.7BA0D1B5@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Dec 2002 01:29:33 +0000
Message-Id: <1039310973.27923.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-07 at 22:49, Andrew Morton wrote:
> Jorg de Jong wrote:
> Well, you must have a card which is newer than the driver understands.
> That's one for the IDE guys...

My guess is he has a card whose timings we don't support. In that case
we punt to avoid crashing later or data loss. Timings for that is one
for Andre & HPT


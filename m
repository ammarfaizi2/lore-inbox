Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132130AbRCVSI5>; Thu, 22 Mar 2001 13:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132128AbRCVSIr>; Thu, 22 Mar 2001 13:08:47 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30472 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132130AbRCVSIf>; Thu, 22 Mar 2001 13:08:35 -0500
Subject: Re: Thinko in kswapd?
To: mikeg@wen-online.de (Mike Galbraith)
Date: Thu, 22 Mar 2001 18:09:59 +0000 (GMT)
Cc: sct@redhat.com (Stephen C. Tweedie), linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox),
        arjanv@redhat.com, torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <Pine.LNX.4.33.0103221837360.665-100000@mikeg.weiden.de> from "Mike Galbraith" at Mar 22, 2001 06:53:18 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14g9X7-00030H-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> pull it all right back in again.  It continues through the entire
> build with the cost seen in the time numbers.  (the ac20.virgin run
> was worse by 30 secs than average, but that doesn't matter much)

Using my reference interactive test (An application which renders 3D graphics 
and generates fairly measurable VM traffic with AGP texture mapping)[1] the
graphical flow is noticably stalling where it didn't before.

Throughput seems to be up but interactivity is bad.

Alan

[1] Tux racer



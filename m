Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRABWIE>; Tue, 2 Jan 2001 17:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131673AbRABWHy>; Tue, 2 Jan 2001 17:07:54 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57092 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131171AbRABWHg>; Tue, 2 Jan 2001 17:07:36 -0500
Subject: Re: Happy new year^H^H^H^Hkernel..
To: faith@valinux.com (Rik Faith)
Date: Tue, 2 Jan 2001 21:37:47 +0000 (GMT)
Cc: kaos@ocs.com.au (Keith Owens), torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List),
        dri-devel@lists.sourceforge.net (DRI Development)
In-Reply-To: <14930.17815.720457.433064@light.alephnull.com> from "Rik Faith" at Jan 02, 2001 04:18:15 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14DZ7u-0002wI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> haven't finished this work yet.  With this new work, however, the
> end-user will still load a single module (e.g., tdfx.o), just like now.
> (Loading a single kernel module is a significant win when dealing with
> end users: there is no possibility of version skew or of having two
> modules that were compiled with different options.)

So with 3 video cards I have 3 wasted chunks of ram just because of a tiny
tiny possibility that someone would manage to build two copies of the library
with matching ksyms. That doesnt strike me as a good tade off
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

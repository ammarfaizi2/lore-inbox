Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291654AbSBAJts>; Fri, 1 Feb 2002 04:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291656AbSBAJtj>; Fri, 1 Feb 2002 04:49:39 -0500
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:30140 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S291655AbSBAJtc>; Fri, 1 Feb 2002 04:49:32 -0500
Date: Fri, 1 Feb 2002 09:49:28 +0000 (GMT)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: <alastair@gurney>
To: <linux-kernel@vger.kernel.org>
Subject: O(1) scheduler observations
Message-ID: <Pine.GSO.4.33.0202010940320.12546-100000@gurney>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo & others....

Just a brief observation on the O(1) scheduler. I'm using 2.4.18-pre7 +
J7 scheduler patch (haven't had a chance to try J9 yet), on a
bog-standard Celeron 500MHz / 384Mb / IDE desktop machine under Red Hat
7.2.

I'm blasting along in Tuxracer (discovery of the week!) and then
"updatedb" kicks in. Tuxracer crawls and jerks for about 15 seconds,
and then turns wonderfully smooth again, whilst the drive continues to
thrash a while longer.

Forgive me if this isn't a relevant scheduler effect, but it struck me
that it might be worth commenting on.

OTOH, using 2.4.17-J6 on a dual Athlon server here, it works great. The
server gets occasionally hammered by fat single-threaded (WINE) jobs,
and the CPU affinity is really working. No more jumping between
processors as it does on stock kernels.

Cheers
Alastair

o o o o o o o o o o o o o o o o o o o o o o o o o o o o
Alastair Stevens           \ \
MRC Biostatistics Unit      \ \___________ 01223 330383
Cambridge UK                 \___ www.mrc-bsu.cam.ac.uk


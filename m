Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSGQQRJ>; Wed, 17 Jul 2002 12:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSGQQRJ>; Wed, 17 Jul 2002 12:17:09 -0400
Received: from mail3.ucc.ie ([143.239.128.103]:36107 "EHLO mail3.ucc.ie")
	by vger.kernel.org with ESMTP id <S315358AbSGQQRI>;
	Wed, 17 Jul 2002 12:17:08 -0400
Message-ID: <9FBB394A25826C46B2C6F0EBDAD42755018E6E47@xch2.ucc.ie>
From: "O'Riordan, Kevin" <K.ORiordan@ucc.ie>
To: "'Roger Luethi'" <rl@hellgate.ch>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Problem with Via Rhine- Kernel 2.4.18
Date: Wed, 17 Jul 2002 17:19:56 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried it against 2.4.19-rc1, and it worked fine for me. Came up with one
hunk failed, but that was in the comments section at the beginning so didn't
matter, the rest of the hunks succeeded at offsets.

-----Original Message-----
From: Roger Luethi [mailto:rl@hellgate.ch] 
Sent: 17 July 2002 15:35
To: O'Riordan, Kevin
Cc: 'Joseph Wenninger'; linux-kernel@vger.kernel.org
Subject: Re: Problem with Via Rhine- Kernel 2.4.18

> in May which fixed the problem and a new patch just a few days ago against
> 2.4.19-rc1(and against 2.4.19-rc2 as well I'd say as the via-rhine driver

Actually, the patch is against Jeff's public tree, which is somewhat
different from what's in rc1, against which I guess the patch will succeed
with offsets (rejecting the changelog portion, which is okay).

You can also try the ac kernel. Alan has the Rhine changes merged since
2.4.19-rc1-ac6.

Roger

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132852AbRDPEFX>; Mon, 16 Apr 2001 00:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132855AbRDPEFN>; Mon, 16 Apr 2001 00:05:13 -0400
Received: from quechua.inka.de ([212.227.14.2]:13348 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S132851AbRDPEFE>;
	Mon, 16 Apr 2001 00:05:04 -0400
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: fsck, raid reconstruction & bad bad 2.4.3
In-Reply-To: <p05100b09b7000a8c3bc9@207.213.214.34>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.36 (i686))
Message-Id: <E14p0G7-0001Sa-00@sites.inka.de>
Date: Mon, 16 Apr 2001 06:05:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <p05100b09b7000a8c3bc9@207.213.214.34> you wrote:
> Is this a pathological case because of the way fsck does business, or does the RAID re-sync affect any disk-bound process that severely?

i gues the seeks are the problem. fsck will quite heavyly reposition, so does
the rebuild, most likely on different ends of the disk.

Greetings
Bernd

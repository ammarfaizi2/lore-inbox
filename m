Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266125AbRGDS1g>; Wed, 4 Jul 2001 14:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266123AbRGDS10>; Wed, 4 Jul 2001 14:27:26 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:28424 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S266119AbRGDS1O>; Wed, 4 Jul 2001 14:27:14 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: O_DIRECT! or O_DIRECT?
Date: Wed, 4 Jul 2001 18:27:13 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9hvn61$rkb$1@ncc1701.cistron.net>
In-Reply-To: <E15HWsV-0000lM-00@f12.port.ru> <20010704185230.F28793@redhat.com>
X-Trace: ncc1701.cistron.net 994271233 28299 195.64.65.67 (4 Jul 2001 18:27:13 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010704185230.F28793@redhat.com>,
Stephen C. Tweedie <sct@redhat.com> wrote:
>For these reasons, buffered IO is often faster than O_DIRECT for pure
>sequential access.  The downside it its greater CPU cost and the fact
>that it pollutes the cache (which, in turn, causes even _more_ CPU
>overhead when the VM is forced to start reclaiming old cache data to
>make room for new blocks.)

Any chance of something like O_SEQUENTIAL (like madvise(MADV_SEQUENTIAL))

Mike.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283511AbRK3EuO>; Thu, 29 Nov 2001 23:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283507AbRK3EuE>; Thu, 29 Nov 2001 23:50:04 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:4996 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S283498AbRK3Et4>;
	Thu, 29 Nov 2001 23:49:56 -0500
Message-ID: <3C070FEC.3602CB49@pobox.com>
Date: Thu, 29 Nov 2001 20:49:48 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16-tux2-ll i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nathan Poznick <poznick@conwaycorp.net>
CC: Sven Heinicke <sven@research.nj.nec.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 freezed up with eepro100 module
In-Reply-To: <15366.21354.879039.718967@abasin.nj.nec.com> <20011129095107.A17457@conwaycorp.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Poznick wrote:

> Thus spake Sven Heinicke:
> >
> > The 2.4.16 kernel finally makes my clients happy with memory
> > management.  The systems that froz up is a Dell of some sort or other
> > with two 1Ghz Pentium IIIs and 4G of memory.  But, now I seems to be
> > having ethernet problems.  With and eepro100 card:
>
> I've encountered the same problem, with the same hardware setup (I
> believe it's a Dell 2400, or something like that), on 2.4.14+xfs.  For
> me it didn't lock up the entire machine however, it only seemed to
> kill the network - I was able to reboot the machine cleanly once I got
> to the console. (message from yesterday with the subject 'failed
> assertion in tcp.c')  I too, am open to suggestions :-)

Similar experience here - the network connectivity
would go away, but the machine was still alive.

Using the e100 driver instead seemed to solve the
problem on the dell servers here.

But I didn't have to reboot - just stopped networking,
unloaded the eepro100 drivers, loaded the e100
drivers and started networking.

cu

jjs



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265412AbRF2Cdb>; Thu, 28 Jun 2001 22:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265418AbRF2CdW>; Thu, 28 Jun 2001 22:33:22 -0400
Received: from quechua.inka.de ([212.227.14.2]:14394 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S265412AbRF2CdE>;
	Thu, 28 Jun 2001 22:33:04 -0400
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux and system area networks
In-Reply-To: <52d77o46ra.fsf@love-boat.topspincom.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E15Fo5g-0006n4-00@sites.inka.de>
Date: Fri, 29 Jun 2001 04:33:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <52d77o46ra.fsf@love-boat.topspincom.com> you wrote:
> We seem to have come full circle.  My original question was about
> providing a better way for sockets applications to take advantage of
> SAN hardware.  W2K Datacenter introduces "Winsock Direct," which will
> bypass the protocol stack when appropriate.  The Infiniband people are
> working on a "Sockets Direct" standard, which is a similar idea.  No
> one seems to care about this for Linux.

Well, there is some work done by the zero-copy folks and the sendfile()
function. Realy much more than a mmaped network socket is not needed.

Besides it looks like SAN will go all the way in the IP Direction sooner or
later anyway :)

There are some interesting Features like accessing MS SQL 7.0 Server via VIA
architecture interfaces over SAN, I am not sure o how open VIA is.

Greetings
Bernd

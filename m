Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262209AbREQXDs>; Thu, 17 May 2001 19:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbREQXDi>; Thu, 17 May 2001 19:03:38 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59911 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262210AbREQXD0>; Thu, 17 May 2001 19:03:26 -0400
Subject: Re: Kernel bug with UNIX sockets not detecting other end gone?
To: chris@scary.beasts.org (Chris Evans)
Date: Thu, 17 May 2001 23:59:55 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <Pine.LNX.4.30.0105172353480.13175-100000@ferret.lmh.ox.ac.uk> from "Chris Evans" at May 17, 2001 11:57:45 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150WkN-0006JK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following program blocks indefinitely on Linux (2.2, 2.4 not tested).
> Since the other end is clearly gone, I would expect some sort of error
> condition. Indeed, FreeBSD gives ECONNRESET.

Since its a datagram socket Im not convinced thats a justifiable assumption.

Alan


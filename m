Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129730AbRCFSbX>; Tue, 6 Mar 2001 13:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129797AbRCFSbN>; Tue, 6 Mar 2001 13:31:13 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2571 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129730AbRCFSbH>; Tue, 6 Mar 2001 13:31:07 -0500
Subject: Re: Inadequate documentation: sockets
To: alex@baretta.com (Alessandro Baretta)
Date: Tue, 6 Mar 2001 18:34:08 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3AA52916.5FD87258@baretta.com> from "Alessandro Baretta" at Mar 06, 2001 07:14:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14aMHj-0001E1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> =46inally I'm left with my original problem: how am I supposed to
> detect a close or a shutdown from the peer? Once again, I thank in
> advance anyone who will lend me a hand by explaining this to me or
> by addressing me to more adequate documentation.

By an EOF on read or getting SIGPIPE/EPIPE on a write. You might want to pick
up a book on the subject of network programming. There are some very nice ones
around

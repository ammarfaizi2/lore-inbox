Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271363AbRHOStz>; Wed, 15 Aug 2001 14:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271361AbRHOSto>; Wed, 15 Aug 2001 14:49:44 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18189 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271360AbRHOStf>; Wed, 15 Aug 2001 14:49:35 -0400
Subject: Re: 2.4.8 Resource leaks + limits
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 15 Aug 2001 19:51:38 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mag@fbab.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108150952001.2220-100000@penguin.transmeta.com> from "Linus Torvalds" at Aug 15, 2001 09:53:09 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15X5lS-0003m6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, it would mean that the primary group is _really_ primary, but from a
> system management standpoint that's probably preferable (ie you can give
> group read-write access to a person without giving group "resource" access
> to him)

Non unix systems generally have a separate accounting uid - one reason for
that is the problem of charging for setuid apps and things done in your
name. Otherwise its all too easy to attack a bug in a setuid app to make it
expand to fill memory.

I'd rather we had an luid or equivalent personally.

Alan

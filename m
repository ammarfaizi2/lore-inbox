Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281441AbRKLMrs>; Mon, 12 Nov 2001 07:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281383AbRKLMri>; Mon, 12 Nov 2001 07:47:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56588 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281438AbRKLMrZ>; Mon, 12 Nov 2001 07:47:25 -0500
Subject: Re: Oops in reiserfs w/2.4.7-10
To: reiser@namesys.com (Hans Reiser)
Date: Mon, 12 Nov 2001 12:54:39 +0000 (GMT)
Cc: brett@bad-sports.com, linux-kernel@vger.kernel.org
In-Reply-To: <3BEFBDE0.6080804@namesys.com> from "Hans Reiser" at Nov 12, 2001 03:17:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163Gbn-0005kK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please upgrade to a recent linus kernel.  I don't know what went into 
> RedHat 7.2, but secondhand reports are that reiserfs is not stable in 
> that kernel.

I wouldnt upgrade to a Linus kernel. That lacks several drivers, ext3, 32bit
uid capable quota and some other stuff. 2.4.15pre3 has some of that now.

You should however grab the Red Hat errata (2.4.9 series) kernel either
via up2date or from a Red Hat ftp archive. That fixes several things.

Alan

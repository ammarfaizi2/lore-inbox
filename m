Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136017AbRDVKXL>; Sun, 22 Apr 2001 06:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136018AbRDVKXC>; Sun, 22 Apr 2001 06:23:02 -0400
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:48390 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S136017AbRDVKWu>; Sun, 22 Apr 2001 06:22:50 -0400
Date: Sun, 22 Apr 2001 11:22:11 +0100 (BST)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, CML2 <linux-kernel@vger.kernel.org>,
        <kbuild-devel@lists.sourceforge.net>
Subject: Re: Request for comment -- a better attribution system
In-Reply-To: <20010421194706.A14896@thyrsus.com>
Message-ID: <Pine.LNX.4.30.0104221114020.10515-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2001, Eric S. Raymond wrote:

> Alan, if MAINTAINERS scaled perfectly I wouldn't have had to spend
> three months just trying to figure out who was reponsible for each of
> the [Cc]onfig.in files.  And even with that amount of effort mostly
> failing.

I have a much simpler proposal, which appears to solve your
immediate problem, and would keep most people happy -- add a:

C: CONFIG_SCSI_BLARG

tag to MAINTAINERS.  If you _really_ insist, add an:

F: drivers/scsi/blarg.c
F: drivers/scsi/blarg.h

too.  It removes the ambiguity inherent in the current system,
without adding an overengineered solution with no obvious
advantages.

Matthew.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263641AbTJZTkr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 14:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTJZTkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 14:40:47 -0500
Received: from hera.cwi.nl ([192.16.191.8]:40592 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263641AbTJZTkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 14:40:46 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 26 Oct 2003 20:40:32 +0100 (MET)
Message-Id: <UTC200310261940.h9QJeWa04880.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, torvalds@osdl.org
Subject: Re: Linux 2.6.0-test9
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Linus Torvalds <torvalds@osdl.org>

    > I have run 2.6.0-test6 without any problems. Switched
    > to 2.6.0-test9 today. Something involving job control
    > or so is broken. Several of my remote xterms hang.

    Btw, this one sounds like a known bug in bash.

No - it is a recent kernel bug.
Mikael Pettersson noticed precisely the same thing, and says
 "Reverting 2.6.0-test8-bk3's net/ipv4/tcp.c patch fixes
  these problems."
And so it does.

Andries


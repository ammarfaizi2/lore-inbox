Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261369AbRFJRyj>; Sun, 10 Jun 2001 13:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261459AbRFJRy3>; Sun, 10 Jun 2001 13:54:29 -0400
Received: from imladris.infradead.org ([194.205.184.45]:57106 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S261369AbRFJRyK>;
	Sun, 10 Jun 2001 13:54:10 -0400
Date: Sun, 10 Jun 2001 18:53:43 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <pfaffben@msu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ess maestro, support for hardware volume control
In-Reply-To: <E1594xc-0006ZB-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106101851570.18035-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan.

 >> What can happen as I see it is that userspace #2, which wants to
 >> talk to a particular misc driver, actually ends up talking to a
 >> different one because the minor gets reassigned between reading
 >> /proc/misc to find out the number and mknoding and opening the
 >> device:

 > Looks true to me. So get a real misc device assigned for
 > anything you use 8)

Wasn't the basis for devfs that it would effectively do the mknod'ing
for you? Or have I completely misunderstood the situation?

Best wishes from Riley.


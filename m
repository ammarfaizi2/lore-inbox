Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272818AbRIWUBY>; Sun, 23 Sep 2001 16:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272817AbRIWUBP>; Sun, 23 Sep 2001 16:01:15 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30483 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272773AbRIWUBF>; Sun, 23 Sep 2001 16:01:05 -0400
Subject: Re: [PATCH] tty canonical mode: nicer erase behaviour
To: zefram@fysh.org
Date: Sun, 23 Sep 2001 21:05:56 +0100 (BST)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <E15kyyG-0000mq-00@dext.rous.org> from "zefram@fysh.org" at Sep 23, 2001 02:26:16 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15lFVk-0000Ex-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One of the long-standing problems preventing Unix from being a
> user-friendly desktop OS is its handling of erase keys.  There are

Not a kernel space issue

> often two such keys on a keyboard (Backspace and Delete), and which one
> works depends very much on context -- many text editing programs will
> only accept one of the erase-related characters (^H and ^?), and the

They do different things, they are different keys.

Erase character policy is precisely defined by posix. Fix problem apps. 
Debian set a policy on this a long time back and have done wonders since

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262184AbREQV0q>; Thu, 17 May 2001 17:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262188AbREQV0h>; Thu, 17 May 2001 17:26:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43014 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262184AbREQV0U>; Thu, 17 May 2001 17:26:20 -0400
Subject: Re: [patch] 2.4.0, 2.2.18: A critical problem with tty_io.c
To: alborchers@steinerpoint.com
Date: Thu, 17 May 2001 22:23:20 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, macro@ds2.pg.gda.pl, tytso@mit.edu,
        pberger@brimson.com (Peter Berger), jamesp@dgii.com (James Puzzo)
In-Reply-To: <3B042DD9.3BDA84D1@steinerpoint.com> from "Al Borchers" at May 17, 2001 03:00:25 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150VEu-0006AM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ted can you get this patch in the kernel or ban it as interface breaking
> heresy?  It would be much nicer for us device driver writers to have just
> one interface to support.

It has to be changed, the race is basically unfixable any other way. I didn't
lightly make that change


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTKFKmP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 05:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTKFKmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 05:42:15 -0500
Received: from aun.it.uu.se ([130.238.12.36]:27013 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263496AbTKFKmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 05:42:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16298.9581.546928.685224@alkaid.it.uu.se>
Date: Thu, 6 Nov 2003 11:41:49 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Matt <dirtbird@ntlworld.com>,
       herbert@gondor.apana.org.au,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [MOUSE] Alias for /dev/psaux
In-Reply-To: <20031105180035.GB27922@ucw.cz>
References: <20031105170217.GA27752@ucw.cz>
	<Pine.LNX.4.44.0311050920080.11208-100000@home.osdl.org>
	<20031105180035.GB27922@ucw.cz>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik writes:
 > IMO sane values are
...
 > 	* 1:1 scaling
 > 		+ has anyone ever changed this one?

I reset it to 2:1 while trying to get the PS/2 mouse attached to
my Dell laptop to work "reasonably". I never was fully successful
because I didn't know how the different parameters interacted --
the recent posts to LKML has clarified that.

Currently I only use psmouse_noext, which is absolutely required
to prevent total mayhem. (You wouldn't believe what crap it spews
out otherwise after a resume from suspend.)

/Mikael

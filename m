Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286647AbRLVC7R>; Fri, 21 Dec 2001 21:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286651AbRLVC7H>; Fri, 21 Dec 2001 21:59:07 -0500
Received: from sushi.toad.net ([162.33.130.105]:22509 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S286647AbRLVC7D>;
	Fri, 21 Dec 2001 21:59:03 -0500
Subject: PnP BIOS driver update
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 21 Dec 2001 21:59:12 -0500
Message-Id: <1008989954.801.4.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch to add the PnP BIOS driver has been updated:
   http://panopticon.csustan.edu/thood/pnpbios.html

The "nobiospnp" kernel parameter has been replaced by
"pnpbios=" with the following arguments:
   on           enable driver
   off          disable driver
   [no-]curr    [don't] give access to the "current" config
   [no-]res     [don't] reserve ioports used by system devices

Default is on,curr,res.
Patch is against 2.4.17-rc1, but it should apply to 2.4.16 and
2.4.17 too.

Please let me know right away if you have any problems.

--
Thomas Hood


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTLJD7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 22:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbTLJD7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 22:59:11 -0500
Received: from pop.gmx.net ([213.165.64.20]:59619 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262360AbTLJD7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 22:59:09 -0500
Date: Wed, 10 Dec 2003 04:59:08 +0100 (MET)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <20031210004120.GB2196@kroah.com>
Subject: Re: Badness in kobject_get at lib/kobject.c:439
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <26919.1071028748@www41.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Dec 10, 2003 at 01:36:25AM +0100, Svetoslav Slavtchev wrote:
> > 
> > the attached oops couldn't happen in vanilla kernel ?
> > or should i try without the ruby patches ?
> 
> Can you try it without the ruby patches?  I have no idea what is
> contained in them.
> 

up and running,

will have to debug it with the linuxconsole developers

i somehow thought that i'll get almost full replacement of devfs,
/* except sound & input, parport */

but i'm still missing raw devices, pty*, pts
any ideas ?-)

svetljo

PS.
that is with the small change in driver/char/misc.c

-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
Neu: Preissenkung für MMS und FreeMMS! http://www.gmx.net



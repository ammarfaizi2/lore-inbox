Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266876AbUG1Kdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266876AbUG1Kdp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 06:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266874AbUG1Kdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 06:33:45 -0400
Received: from dwdmx2.dwd.de ([141.38.3.197]:30814 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S266877AbUG1Kdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 06:33:42 -0400
Date: Wed, 28 Jul 2004 10:33:38 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>, minyard@acm.org
Subject: Re: IPMI watchdog question
In-Reply-To: <200407281129.22431.arekm@pld-linux.org>
Message-Id: <Pine.LNX.4.58.0407281021530.31636@praktifix.dwd.de>
References: <Pine.LNX.4.58.0407280901330.31636@praktifix.dwd.de>
 <200407281129.22431.arekm@pld-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004, Arkadiusz Miskiewicz wrote:

> On Wednesday 28 of July 2004 11:08, Holger Kiehl wrote:
> > Hello
> >
> > Using kernel 2.6.7 with ipmi watchdog compiled in, I have noticed that
> > when the process writting to /dev/watchdog is killed (-9) the system is
> > not reset. When I query the BMC to list the SEL it does report:
> >
> >    Watchdog 2 #0x03 | Timer expired
> >
> > So the BMC does notice that the timer did expire but no action is taken.
> > What must I do so it resets my system?
> Do you have CONFIG_WATCHDOG_NOWAYOUT enabled?
> 
No this is not set. Must this be set? Actually I want that one can stop the
watchdog gracefully. And this is done by writting a 'V' to /dev/watchdog,
correct? 

I noticed that CONFIG_WATCHDOG is also not set since CONFIG_IPMI_WATCHDOG
is set under IPMI. Must this be set? Is the IPMI watchdog different to
all the other watchdogs or why is it listed seperatly?

Holger

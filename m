Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268256AbTBNI6f>; Fri, 14 Feb 2003 03:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268325AbTBNI6f>; Fri, 14 Feb 2003 03:58:35 -0500
Received: from [81.2.122.30] ([81.2.122.30]:6660 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S268256AbTBNI6e>;
	Fri, 14 Feb 2003 03:58:34 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302140908.h1E98xaJ000400@darkstar.example.net>
Subject: Re: 2.5.60 cheerleading...
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 14 Feb 2003 09:08:59 +0000 (GMT)
Cc: mbligh@aracnet.com, plars@linuxtestproject.org, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0302131731090.2655-100000@home.transmeta.com> from "Linus Torvalds" at Feb 13, 2003 05:32:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Or you just persaude Linus to release kernels first thing in the morning,
> > not last thing at night.
> 
> Ok, now the thread has moved from the strange to the surreal.

Fed up with all these people trying to tell you when to release new
kernels?  Now you can just use this simple script to do it
automatically!

#!/bin/sh
echo "Release a new kernel now!!!" > /tmp/kernel_reminder
echo "30 6 * * * /usr/bin/cat /tmp/kernel_reminder | mail root" >> /var/spool/cron/crontabs/root 

John.

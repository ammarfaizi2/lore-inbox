Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbTDVHzH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 03:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTDVHzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 03:55:07 -0400
Received: from [80.190.48.67] ([80.190.48.67]:46596 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262982AbTDVHzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 03:55:06 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Michael B Allen <mba2000@ioplex.com>, linux-kernel@vger.kernel.org
Subject: Re: What's the deal McNeil? Bad interactive behavior in X w/ RH's 2.4.18
Date: Tue, 22 Apr 2003 10:06:59 +0200
User-Agent: KMail/1.5.1
References: <20030422034821.6a57acc0.mba2000@ioplex.com>
In-Reply-To: <20030422034821.6a57acc0.mba2000@ioplex.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200304221006.09601.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 April 2003 09:48, Michael B Allen wrote:

Hi Michael,

> I'm running Red Hat 7.3 with their stock 2.4.18-3 kernel on an IBM
> T30. Once every few hours X locks up for 5-10 seconds while the disk
> grinds. If I type in an Xterm the characters are not echoed until the
> disk grinding stops. Then they all come out in a bunch and life is back
> to normal.
> I asked about this on kernelnewbies but the only response was something
> regarding some kind of change to the 'elevator code' but they didn't
> know of a solution.
The problem is, since 2.4.19-pre5 the elevator has changed to give more 
throughput but also introduce pauses and even stops while disk i/o.

Redhat's 2.4.18 is not 2.4.18 but something 2.4.19ish(-pre|-pre-ac or so).

> I would like very much for this behavior to go away as it is extremely
> annoying. If there is a patch please let me know where I can get it.
There are some hacks. One by Andrea Arcangeli, one by Neil Schemenauer and one 
by Con Kolivas and me. Search the archives please (lowlat elevator/io 
scheduler)

ciao, Marc

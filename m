Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272449AbSISTNs>; Thu, 19 Sep 2002 15:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272493AbSISTNs>; Thu, 19 Sep 2002 15:13:48 -0400
Received: from khms.westfalen.de ([62.153.201.243]:29093 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S272449AbSISTNq>; Thu, 19 Sep 2002 15:13:46 -0400
Date: 19 Sep 2002 21:10:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Message-ID: <8XBysGvmw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.44.0209190938340.1594-100000@home.transmeta.com>
Subject: Re: [patch] generic-pidhash-2.5.36-D4, BK-curr
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <Pine.LNX.4.44.0209190938340.1594-100000@home.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 19.09.02 in <Pine.LNX.4.44.0209190938340.1594-100000@home.transmeta.com>:

> On Thu, 19 Sep 2002, Andries Brouwer wrote:

> > [POSIX 1003.1-2001]

> > The controlling terminal is inherited by a child process during a fork()
> > function call. A process relinquishes its controlling terminal when it
> > creates a new session with the setsid() function; other processes
> > remaining in the old session that had this terminal as their controlling
> > terminal continue to have it.
>
> Well, that certainly clinches the fact that the controlling terminal _can_
> and does continue to be hold by processes outside the current session
> group.

On the contrary: it says that this can never happen - the new session has  
no controlling terminal, and can't get the old one unless the old session  
loses it first.

MfG Kai

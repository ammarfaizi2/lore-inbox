Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWAQURI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWAQURI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWAQURI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:17:08 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:23738 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964806AbWAQURH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:17:07 -0500
Subject: Re: X killed
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>,
       Willy Tarreau <willy@w.ods.org>,
       linux mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0601172111070.11929@yvahk01.tjqt.qr>
References: <43CA883B.2020504@superbug.demon.co.uk>
	 <20060115192711.GO7142@w.ods.org> <43CCE5C8.7030605@superbug.demon.co.uk>
	 <Pine.LNX.4.61.0601172111070.11929@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 15:17:04 -0500
Message-Id: <1137529025.19678.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 21:12 +0100, Jan Engelhardt wrote:
> >
> > My point is that there is no way to tell what kills me. No messages in
> > syslog...nothing. Surely the OOM killer would send a message to ksyslog, or at
> > least dmesg?
> >
> Yes, OOM usually does printk(). So it depends on how you have syslog set 
> up (and the console loglevel - which is reponsible for bringing it right 
> to console).

I think you are missing the point - the problem is almost certainly NOT
an OOM condition as there's nothing in the logs.  It's a bug in the X
server.  The question is, how does one debug that.

Here is the original question again:

"I have a python application that kills X. I.e. the X process
terminates,and all X programs receive broken links to the display and
therefore also exit.

The problem is, this python application is not supposed to kill 
anything, so I think it is a bug in X, but I cannot find any way to 
trace the fault. Even gdb says the application was killed, so exited 
normally, and results in no back trace.

Is there any way in Linux to find out who did the "killing" ?"

Lee


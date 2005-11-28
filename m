Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVK1PiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVK1PiP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 10:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbVK1PiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 10:38:15 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:25764 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932084AbVK1PiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 10:38:15 -0500
Subject: Re: [RT] read_tsc: ACK! TSC went backward! Unsynced TSCs?
From: Lee Revell <rlrevell@joe-job.com>
To: Jonas Oreland <jonas@mysql.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <438AF860.7050905@mysql.com>
References: <1133179554.11491.3.camel@localhost.localdomain>
	 <438AF860.7050905@mysql.com>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 10:38:10 -0500
Message-Id: <1133192290.5228.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-28 at 13:30 +0100, Jonas Oreland wrote:
> Steven Rostedt wrote:
> > Hi Ingo,
> > 
> > With -rt20 on the AMD64 x2, I'm getting a crap load of these:
> > 
> > read_tsc: ACK! TSC went backward! Unsynced TSCs?
> > 
> > So bad that the system wont even boot (at least I won't wait long enough
> > to let it finish).
> > 
> > config at: http://www.kihontech.com/tests/rt/config
> 
> Check this: http://bugzilla.kernel.org/show_bug.cgi?id=5105
> 
> Booting with idle=poll, fixes that.
> 

But that bug is marked fixed over a month ago.  Isn't the fix in 2.6.14?

Lee


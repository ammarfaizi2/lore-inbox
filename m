Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267606AbUHJSZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267606AbUHJSZL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267618AbUHJSWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:22:11 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:8621 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267625AbUHJSUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:20:11 -0400
Subject: Re: Fork and Exec a process within the kernel
From: Lee Revell <rlrevell@joe-job.com>
To: Paul Jackson <pj@sgi.com>
Cc: Eric Masson <cool_kid@future-ericsoft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040810092116.7dfe118c.pj@sgi.com>
References: <4117E68A.4090701@future-ericsoft.com>
	 <20040809161003.554a5de1.pj@sgi.com> <4118E822.3000303@future-ericsoft.com>
	 <20040810092116.7dfe118c.pj@sgi.com>
Content-Type: text/plain
Message-Id: <1092162030.782.28.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 14:20:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 12:21, Paul Jackson wrote:
> > My user mode program is running.
> 
> Good.
> 
> > Any idea how to control which console it shows up on?
> 
> No clue.

OK, ignore the peanut gallery, this is the real answer:

./foo > /dev/tty1

See /etc/syslog.conf on Debian for another example.  Anywhere you could
write to a file you can write to /dev/tty$FOO and it will do the right
thing.

UNIX is full of stuff like this.  Pretty cool, huh?

Lee




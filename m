Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbTKZVfB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 16:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbTKZVfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 16:35:00 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:60312 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S264334AbTKZVe6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 16:34:58 -0500
Date: Wed, 26 Nov 2003 22:34:55 +0100
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocglinux@yahoo.es>
To: Linus Torvalds <torvalds@osdl.org>
Cc: wli@holomorphy.com, gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: amanda vs 2.6
Message-Id: <20031126223455.33c9105b.diegocglinux@yahoo.es>
In-Reply-To: <Pine.LNX.4.58.0311261202050.1524@home.osdl.org>
References: <200311261212.10166.gene.heskett@verizon.net>
	<200311261415.52304.gene.heskett@verizon.net>
	<20031126193059.GS8039@holomorphy.com>
	<200311261443.43695.gene.heskett@verizon.net>
	<20031126195049.GT8039@holomorphy.com>
	<Pine.LNX.4.58.0311261202050.1524@home.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 26 Nov 2003 12:04:56 -0800 (PST) Linus Torvalds <torvalds@osdl.org> escribió:

> I've seen this before, and I'll bet you 5c (yeah, I'm cheap) that it's
> trying to log to syslogd.
> 
> And syslogd is stopped for some reason - either a bug, a mistaken SIGSTOP,
> or simply because the console has been stopped with a simple ^S.
> 
> That won't stop "su" working immediately - programs can still log to
> syslogd until the logging socket buffer fills up. Which can be _damn_
> frsutrating to find (I haven't seen this behaviour lately, but I remember
> being perplexed like hell a long time ago).

I've seen this too. I could fix it with "sysrq + s". I always though
it was a bug in syslogd. I haven't seen it in a while...

Diego Calleja

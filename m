Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272215AbRHWE2j>; Thu, 23 Aug 2001 00:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272216AbRHWE2T>; Thu, 23 Aug 2001 00:28:19 -0400
Received: from pD903C758.dip.t-dialin.net ([217.3.199.88]:22914 "EHLO
	no-maam.dyndns.org") by vger.kernel.org with ESMTP
	id <S272215AbRHWE2P>; Thu, 23 Aug 2001 00:28:15 -0400
Date: Wed, 22 Aug 2001 16:43:14 +0200
To: linux-kernel@vger.kernel.org
Subject: Writing oops-messages to floppy or disk
Message-ID: <20010822164314.B31151@no-maam.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: erik.tews@gmx.net (Erik Tews)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Some days ago, I had the problem that the isdn-router in our school
crashed (was a problem with mppp, I am currently talking with the
isdn-guys). I had a oops-message on my screen. My kernel has had
magic-sysrq-support. So I needed this message somewhere to give it so
ksymoops. The only solution I had was typing it into my laptop by hand.

So I would like to know if there is a solution to tell the kernel to
write the current screen (or the oops-message) to floppy (bypassing the
filesystem, just raw write, reading it back with dd if=/dev/fd0, of=-)
The only option I have with ksymoops is syncing my filesystems, but most
time, the kernel freezes before syslogd is able to write it to the
filesystem. Or an other solution to get the message to resistant memory.

Typing the message by hand into my laptop is a bad thing, because it
takes a lot of time, and during this time, the system is down.

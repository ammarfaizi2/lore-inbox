Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTFPIYY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 04:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTFPIYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 04:24:24 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:12482 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S263573AbTFPIYW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 04:24:22 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.21 crashes hard running cdrecord in X.
Mail-Copies-To: never
References: <1055722972.1502.39.camel@spike.sunnydale>
	<200306161055.13996.kernel@kolivas.org>
	<1055728825.1482.8.camel@spike.sunnydale>
	<1055731591.2028.4.camel@spike.sunnydale>
From: Roland Mas <roland.mas@free.fr>
Date: Mon, 16 Jun 2003 10:38:13 +0200
Message-ID: <87y9025sei.fsf@free.fr>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per Nystrom, 2003-06-15 19:46:31 -0700 :

> The hard crash occurs only when magicdev is running.  I tried
> turning off all my preferences for auto- mounting, running, and
> playing data/audio cds in my preferences, and voila!  cdrecord works
> without a hiccup in X too.

I don't know what this magicdev thing is, but from what you say you
turned off I assume it's something that accesses the CD drive and
polls its status regularly.  So your problem looks remarkably like
mine, which I have already reported here, except I do get a panic.  My
problem occurs when the GNOME 2 CD applet is running, and it seems to
me the culprit is an ioctl() that tries to get the status of the
drive.  Look for my message with "Subject: Still [OOPS] ide-scsi
panic, now in 2.4.21 too" (just reposted it, first time only went to
specific people).

  Glad to know I'm not alone :-)

Roland.
-- 
Roland Mas

OpenPGP keys on http://www.keyserver.net/

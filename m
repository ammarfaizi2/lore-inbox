Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbTJBQNY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 12:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTJBQNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 12:13:24 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:4808 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263389AbTJBQNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 12:13:23 -0400
To: John Lange <john.lange@bighostbox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: A new model for ports and kernel security?
References: <1065035183.5142.50.camel@mars>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 01 Oct 2003 22:10:02 +0200
In-Reply-To: <1065035183.5142.50.camel@mars>
Message-ID: <m3he2sen39.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Lange <john.lange@bighostbox.com> writes:

> My understanding is that this is a hold-over from ancient days gone past
> where it was meant to be a security feature. Since only root processes
> can listen on ports less than 1024, you could "trust" any connection
> made to a low port to be "secure". In other words, nobody could be
> "bluffing" on a telnet port that didn't have root access therefore it
> was "safe" to type in your password.

It was for rlogin-like accesses, too - the server knew the client is
a suid and trusted program.
Think - NFS.

> Are not processes forced to run as root (at least at startup) that have
> security holes in them not the leading cause of "remote root exploits"?

Not commonly. They usually change ownership to something like www.www
and that is what the exploit gains first.
-- 
Krzysztof Halasa, B*FH

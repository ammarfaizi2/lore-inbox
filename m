Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270007AbTHQNJx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 09:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270009AbTHQNJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 09:09:53 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:30092 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270007AbTHQNJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 09:09:51 -0400
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F3F7A79.1060404@softhome.net>
References: <lg0i.6yo.11@gated-at.bofh.it> <lgjJ.6Oo.5@gated-at.bofh.it>
	 <lilr.p2.7@gated-at.bofh.it> <lj7O.14a.1@gated-at.bofh.it>
	 <3F3F7A79.1060404@softhome.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061125769.21885.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 17 Aug 2003 14:09:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-17 at 13:52, Ihar 'Philips' Filipau wrote:
>      "When  called  with the name of an existing file as argument, 
> ccounting is turned on, records for each  terminating  process  are 
> appended  to filename as it terminates.  An argument of NULL causes 
> accounting to be turned off".
> 
>      I do not see how it relates to abends.
>      It logs _everything_, what is not that useful. Having some kind of 
> filter what to log - whould be just great. Or alternatively ability to 
> pass file descriptor - not file name.

It generates a small record for each exit, its trivial to parse the exit
codes for exits caused by an exception.

>      Sounds like acct() does reverse? No crashes are logged.
>      Or it is about Linux crash?

Linux crash


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266254AbUHWRdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266254AbUHWRdx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUHWRdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:33:36 -0400
Received: from smtp.wp.pl ([212.77.101.160]:46227 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S266308AbUHWRcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:32:47 -0400
Date: Mon, 23 Aug 2004 19:32:41 +0200
From: "Matthew Qvapul" <pikpus@wp.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: strange softdog message on 2.4.20 kernel...
Message-ID: <412a2a39b5831@wp.pl>
References: <412a20af1d388@wp.pl> <1093277771.29850.0.camel@localhost.localdomain>
In-reply-to: <412a20af1d388@wp.pl> <1093277771.29850.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Mailer: Interfejs WWW poczty Wirtualnej Polski
Organization: Poczta Wirtualnej Polski S.A. http://www.wp.pl/
X-IP: 157.25.157.162
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-AS1: NOSPAM                                               
X-WP-AS3: NOSPAM 
X-WP-SPAM: NO 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So probably it means that redhat changed kernel configuration
kernel between versions 2.4.18 and 2.4.20.

Do You approve the fact that my mashine was rebooted because of
such kernel config ?

Greetings

pikpus

Dnia 23-08-2004 o godz. 18:16 Alan Cox napisa³(a):
> On Llu, 2004-08-23 at 17:51, Matthew Qvapul wrote:
> > 2) /sbin/modprobe softdog soft_margin=900
> > 3) grep "adg" > /dev/watchdog
> > 
> > SOFTDOG: WDT device closed unexpectedly.  WDT will not stop!
> 
> You closed it without indicating you meant to close it so the timer
> decided the watchdog daemon had died. Thats configurable when 
> building the kernel (NOWAYOUT option)
> 
> Alan
> 
> 

----------------------------------------------------
Olimpiada na skuterze!
Skutery, aparaty cyfrowe, oryginalne plecaki olimpijskie
czekaj± na chêtnych! ---> Ateny.wp.pl/Konkurs ---> Sprawd¼ siê!
http://klik.wp.pl/?adr=http%3A%2F%2Fateny.wp.pl%2Fkonkurs&sid=226



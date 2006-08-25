Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWHYPV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWHYPV7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWHYPV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:21:58 -0400
Received: from smarthost2.sentex.ca ([205.211.164.50]:59598 "EHLO
	smarthost2.sentex.ca") by vger.kernel.org with ESMTP
	id S1751364AbWHYPV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:21:57 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Krzysztof Halasa'" <khc@pm.waw.pl>
Cc: <linux-serial@vger.kernel.org>, "'LKML'" <linux-kernel@vger.kernel.org>,
       <libc-alpha@sources.redhat.com>
Subject: RE: Serial custom speed deprecated?
Date: Fri, 25 Aug 2006 11:21:21 -0400
Organization: Connect Tech Inc.
Message-ID: <043501c6c85a$1eb09a60$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <1156459387.3007.218.camel@localhost.localdomain>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: On Behalf Of Alan Cox
> We could implement an entirely new TCSETS/TCGETS/TCSETSA/SAW 
> which used
> different B* values so B9600 was 9600 etc and the data was stored in

I think if a numeric baud rate is going to be supported, getting away
from the B* cruft is important. Just use a number.

> Or we could just add a standardised extra set of speed 
> ioctls, but then
> we need to decide what occurs if I set the speed and then issue a
> termios call - does it override or not.

I'd say yes.

..Stu


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310611AbSCHAYO>; Thu, 7 Mar 2002 19:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310614AbSCHAYE>; Thu, 7 Mar 2002 19:24:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23047 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310611AbSCHAX6>; Thu, 7 Mar 2002 19:23:58 -0500
Subject: Re: [PATCH] preempt-kernel on 2.4.19-pre2-ac2 bugfix
To: mfedyk@matchmail.com (Mike Fedyk)
Date: Fri, 8 Mar 2002 00:38:35 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rml@tech9.net (Robert Love),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020308000504.GE28141@matchmail.com> from "Mike Fedyk" at Mar 07, 2002 04:05:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16j8P5-0004NW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm running kde, mutt, mozilla, make -j5 kernel compile on a loop for the
> last coupld days.  I wasn't using this much address space with the same work
> load yesterday, so that's why I think there is a bug there.  

Could be  - or an app decided to spring a leak. You might want to see if
a lot of it vanishes when you kill specific things

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130237AbQL1LvT>; Thu, 28 Dec 2000 06:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132126AbQL1LvJ>; Thu, 28 Dec 2000 06:51:09 -0500
Received: from shell.ca.us.webchat.org ([216.152.64.152]:44012 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S130237AbQL1Lu4>; Thu, 28 Dec 2000 06:50:56 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <brian@worldcontrol.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Which resource is temporarily unavailable
Date: Thu, 28 Dec 2000 03:20:28 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKKELLMKAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20001228001949.A7365@top.worldcontrol.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> zsh: fork failed: resource temporarily unavailable
>
> on a machine.  It has 510 processes which are mostly
> asleep, running under various user ids.

> How do I determine which resource is the problem so I can
> fix the shortage?

	Sounds like processes/tasks is the resource in question. Probably a system
limit of 512 processes.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317251AbSFRBvU>; Mon, 17 Jun 2002 21:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317260AbSFRBvT>; Mon, 17 Jun 2002 21:51:19 -0400
Received: from dsl092-042-129.lax1.dsl.speakeasy.net ([66.92.42.129]:41221
	"EHLO mgix.com") by vger.kernel.org with ESMTP id <S317251AbSFRBvT>;
	Mon, 17 Jun 2002 21:51:19 -0400
From: <mgix@mgix.com>
To: "Robert Love" <rml@tech9.net>, "David Schwartz" <davids@webmaster.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Question about sched_yield()
Date: Mon, 17 Jun 2002 18:51:20 -0700
Message-ID: <AMEKICHCJFIFEDIBLGOBKEEECBAA.mgix@mgix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1024361703.924.176.camel@sinai>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> Seems to me the behavior of sched_yield is a bit broken.  If the tasks
> are correctly returned to the end of their runqueue, this should not
> happen.  Note, for example, you will not see this behavior in 2.5.

Actually, it seems to happen in 2.5 too.
However, Ingo sent me a patch for 2.5.21
that fixes the issue.

See this message:

http://marc.theaimsgroup.com/?l=linux-kernel&m=102423901727214&w=2

	- Mgix

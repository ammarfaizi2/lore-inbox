Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317302AbSFRDwN>; Mon, 17 Jun 2002 23:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317303AbSFRDwM>; Mon, 17 Jun 2002 23:52:12 -0400
Received: from dsl092-042-129.lax1.dsl.speakeasy.net ([66.92.42.129]:49413
	"EHLO mgix.com") by vger.kernel.org with ESMTP id <S317302AbSFRDwL>;
	Mon, 17 Jun 2002 23:52:11 -0400
From: <mgix@mgix.com>
To: "David Schwartz" <davids@webmaster.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Question about sched_yield()
Date: Mon, 17 Jun 2002 20:52:12 -0700
Message-ID: <AMEKICHCJFIFEDIBLGOBEEEFCBAA.mgix@mgix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20020618032149.AAA841@shell.webmaster.com@whenever>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >If willingly and knowingly relinquinshing a CPU does not make it possible
> >for other processes to use what would otherwise have been your very own 
> >slice
> >of processing time then what could it be used for, I really wonder.
> 
> 	It does! That's what it's for.

Good, and now that we agree:

Now back to the original point: sched_yield does not
do the above on Linux as of today, which was the point
of my original posting, and which is the reason Ingo
posted a scheduler patch.

	- Mgix



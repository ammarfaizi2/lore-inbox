Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261719AbREXM3z>; Thu, 24 May 2001 08:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261722AbREXM3p>; Thu, 24 May 2001 08:29:45 -0400
Received: from pop.gmx.net ([194.221.183.20]:13540 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261719AbREXM33>;
	Thu, 24 May 2001 08:29:29 -0400
Message-ID: <003901c0e44d$2de3ea60$093fe33e@host1>
From: "peter k." <spam-goes-to-dev-null@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: patch to put IDE drives in sleep-mode after an halt
Date: Thu, 24 May 2001 14:29:29 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, May 24, 2001 at 12:03:49PM +0100, Rodrigo Ventura wrote:
> >         I am submitting a patch to kernel/sys.c that walks through all
> > IDE drives (#ifdef CONFIG_BLK_DEV_IDE, of course), and issues a
> > "sleep" command (as code in hdparam) to each one of them right before
> > the kernel halts. Here goes the diff:
>
> I'm not going to comment on the idea, just the implementation.  Eww.

imho the idea is very good
i was already wondering why the kernel doesnt spin down the hds when i
shutdown...
and its necessary because if you want to move your box the hd heads should
be parked!
 
 - peter k.
 


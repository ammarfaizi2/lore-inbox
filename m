Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271808AbTGRPca (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271799AbTGRPby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:31:54 -0400
Received: from mail.gmx.de ([213.165.64.20]:24980 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S271777AbTGRPa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 11:30:56 -0400
Message-Id: <5.2.1.1.2.20030718174802.01b168a0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Fri, 18 Jul 2003 17:50:07 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O6int for interactivity
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Davide Libenzi <davidel@xmailserver.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
In-Reply-To: <200307190024.08571.kernel@kolivas.org>
References: <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
 <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
 <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:24 AM 7/19/2003 +1000, Con Kolivas wrote:
>On Fri, 18 Jul 2003 20:18, Mike Galbraith wrote:
> > At 04:34 PM 7/18/2003 +1000, Nick Piggin wrote:
> > >Mike Galbraith wrote:
> > That _might_ (add salt) be priorities of kernel threads dropping too low.
>
>Is there any good reason for the priorities of kernel threads to vary at all?
>In the original design they are subject to the same interactivity changes as
>other processes and I've maintained that but I can't see a good reason for it
>and plan to change it unless someone tells me otherwise.

They're so light now days that I never see them change.  I set bonus 
manually to MAX_BONUS/2 in the last numbers posted.

         -Mike 


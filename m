Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285258AbRLFWcE>; Thu, 6 Dec 2001 17:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285273AbRLFWbs>; Thu, 6 Dec 2001 17:31:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50706 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285265AbRLFWaX>; Thu, 6 Dec 2001 17:30:23 -0500
Subject: Re: SMP/cc Cluster description
To: lm@bitmover.com (Larry McVoy)
Date: Thu, 6 Dec 2001 22:37:18 +0000 (GMT)
Cc: davem@redhat.com (David S. Miller), lm@bitmover.com,
        phillips@bonn-fries.net, davidel@xmailserver.org,
        rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
        lars.spam@nocrew.org, alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011206122116.H27589@work.bitmover.com> from "Larry McVoy" at Dec 06, 2001 12:21:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16C78o-0003LB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    problem.  Scheduler, networking, device drivers, everything.  That's
>    thousands of locks and uncountable bugs, not to mention the impact on
>    uniprocessor performance.

Most of my block drivers in Linux have one lock. The block queuing layer
has one lock which is often the same lock.

> You tell me - which is easier, multithreading the networking stack to 
> 64 way SMP or running 64 distinct networking stacks?

Which is easier. Managing 64 routers or managing 1 router ?

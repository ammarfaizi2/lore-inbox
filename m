Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135346AbRDLVej>; Thu, 12 Apr 2001 17:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135347AbRDLVea>; Thu, 12 Apr 2001 17:34:30 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:41934 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S135346AbRDLVeU>; Thu, 12 Apr 2001 17:34:20 -0400
Message-ID: <3AD61E6A.10D6B654@uow.edu.au>
Date: Thu, 12 Apr 2001 14:30:18 -0700
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18-0.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rod Stewart <stewart@dystopia.lab43.org>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: 8139too: defunct threads
In-Reply-To: <3AD61258.4E8567D8@uow.edu.au> <Pine.LNX.4.33.0104121713490.32117-100000@dystopia.lab43.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rod Stewart wrote:
> 
> On Thu, 12 Apr 2001, Andrew Morton wrote:
> > Is there something unusual about your setup?
> 
> One box is standard PIII with RH 7.0, the other is a custom Crusoe TM5400
> board.  But from further investigation it appears to be a kernel config
> option.  As I've got a 2.4.0 kernel which has very little compiled in and
> not showing the problem and another kernel which has many more networking
> options built in and showing the problem.  I've seen this problem
> since 2.4.0.test11.
> 

Sorry.  I meant: what is process 1 on this machine?  Is it not
the normal init?  If not, then according to Alan, the fault
lies with your userspace.  Kernel requires that PID 1 reap
children.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132983AbRADMx2>; Thu, 4 Jan 2001 07:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132982AbRADMxS>; Thu, 4 Jan 2001 07:53:18 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:13787 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132904AbRADMxL>; Thu, 4 Jan 2001 07:53:11 -0500
Message-ID: <3A54739F.FB8D6F3D@uow.edu.au>
Date: Thu, 04 Jan 2001 23:59:11 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Loth <chris@gidayu.max.uni-duisburg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: DHCP Problems with 3com 3c905C Tornado
In-Reply-To: <20010104123139.A15097@gidayu.max.uni-duisburg.de> <3A546F8E.ABF952F@uow.edu.au>,
		<3A546F8E.ABF952F@uow.edu.au>; from andrewm@uow.edu.au on Thu, Jan 04, 2001 at 11:41:50PM +1100 <20010104134315.C15097@gidayu.max.uni-duisburg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Loth wrote:
> 
> >
> > Did _both_ 3c90x and 3c59x fail, or only 3c59x?
> >
> 
> Both did not work. And 3c59x from 2.2.18 didn't work
> as well, and as far as I could judge 3c90x is not included
> in the kernel proper, right?

Now that is wierd.  They're radically different drivers,
and the 3com one doesn't seem to undergo many changes at
all.

I wonder if the PCI scan order may have changed.  What
other PCI devices did you have in that machine? Any other
NICs?

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135681AbREDBlG>; Thu, 3 May 2001 21:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135689AbREDBkq>; Thu, 3 May 2001 21:40:46 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:33701 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S135681AbREDBkk>; Thu, 3 May 2001 21:40:40 -0400
Message-ID: <3AF20855.D5F565F5@uow.edu.au>
Date: Fri, 04 May 2001 11:39:33 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jalaja devi <jala_74@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Device driver from kernel2.2.x to kernel2.4
In-Reply-To: <E14vO2i-00060Y-00@the-village.bc.nu> <20010503190308.79916.qmail@web13702.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jalaja devi wrote:
> 
> I want to port a Network driver from kernel2.2.x to
> 2.4. Could anyone please point me a handy pointer
> where i can find a complete documentation.

http://www.firstfloor.org/~andi/softnet/

Also, take a look at acenic.c and eepro100.c.  They
both support 2.2 and 2.4.  The compatibility macros
will provide pointers.

> I could find some, but not the complete changes
> required.
> 
> Also, Approximate time estimation for this migration
> from an experienced developer would be much helpful.

It took me about 30 minutes to scruffily hack a 2.2 net
driver into the 2.4 APIs.  I'd allow a day to do it
properly.  Plus another day for testing, especially
if you want to support SMP well.

-

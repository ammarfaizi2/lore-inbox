Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135623AbRD1UBL>; Sat, 28 Apr 2001 16:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135625AbRD1UBB>; Sat, 28 Apr 2001 16:01:01 -0400
Received: from hamachi.synopsys.com ([204.176.20.26]:25057 "EHLO
	hamachi.synopsys.com") by vger.kernel.org with ESMTP
	id <S135623AbRD1UAy>; Sat, 28 Apr 2001 16:00:54 -0400
Message-ID: <3AEB2164.75835700@Synopsys.COM>
Date: Sat, 28 Apr 2001 22:00:36 +0200
From: Harald Dunkel <harri@synopsys.COM>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 sluggish under fork load
In-Reply-To: <Pine.LNX.4.33.0104281322070.1159-100000@ppro.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund wrote:
> 
> I have noticed that 2.4.4 feels a lot less responsive than 2.4.3 under
> fork load. This is caused by the "run child first after fork" patch. I
> have tested on two different UP x86 systems running redhat 7.0.
> 
> For example, when running the gcc configure script, the X mouse pointer is
> very jerky. The configure script itself runs approximately as fast as in
> 2.4.3.
> 

That explains why xtoolwait did not work anymore. After applying the
patch everything is OK again.


Many thanx

Harri

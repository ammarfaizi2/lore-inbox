Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVCIP4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVCIP4G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 10:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbVCIP4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 10:56:05 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:32471 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261948AbVCIPys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 10:54:48 -0500
Message-ID: <422F1ABC.5010505@nortel.com>
Date: Wed, 09 Mar 2005 09:48:12 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: szonyi calin <caszonyi@yahoo.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: RFD: Kernel release numbering
References: <20050308233619.69796.qmail@web52910.mail.yahoo.com>
In-Reply-To: <20050308233619.69796.qmail@web52910.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

szonyi calin wrote:

> Let me tell you what i understood from this thread:
> 2.6.12 "almost stable"
> 2.6.13 devel (new drivers,fixes  and stuff -- may be broken)
> 2.6.14 (based on 2.6.13) tries to became stable again
> 2.6.15 also devel (see above)
> 2.6.16 (based on 2.6.15) also tries to became stable again
> 
> So we will _want_ to have a stable kernel (like 2.4 now) but 
> this will never happen (see above) 

No.  Linus' proposal was shouted down.

What is happening is that Linus will continue to release 2.6.x as usual, 
with no even/odd stuff.

Then a review committee will maintain 2.6.x.y (where y starts at 1 and 
increments).  This will contain obvious fixes against 2.6.x.  When Linus 
comes out with 2.6.x+1, then they will start a new stable tree 2.6.x+1.y.

Please see the thread entitled "[RFC] -stable, how it's going to work.", 
started by Greg KH for more information on the "stable" release process.

Chris

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVE1B44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVE1B44 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 21:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbVE1B44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 21:56:56 -0400
Received: from web33001.mail.mud.yahoo.com ([68.142.206.65]:6261 "HELO
	web33001.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261928AbVE1B4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 21:56:54 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=2wRJ05MaTRuTutQkdoIKagjPJdwEjPdHmLUCVjHrMFWZRuPNm323wUdj+t3Nq9x8SqAfj0AfPlY+zU2ZeUqWPyzhVpwY1kSGDlvKpmQsaySZeVG8wPLSqB0JA9pmg0FrkhyGlMxpSg+PW0b8zsTeC8btbSzBMLMLJPxs5KNalcA=  ;
Message-ID: <20050528015650.75229.qmail@web33001.mail.mud.yahoo.com>
Date: Fri, 27 May 2005 18:56:50 -0700 (PDT)
From: cranium2003 <cranium2003@yahoo.com>
Subject: Re: kernel memory usage any restrictions?
To: Chris Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
--- Chris Friesen <cfriesen@nortel.com> wrote:
> cranium2003 wrote:
> > hello,
> >               Is there any restricition on using
> > kernel's memory? also if i require to use some
> kernel
> > memory say 625kB by allocating that in GFP_ATOMIC
> mode
> 
> Your call will almost certainly fail.  I think
> kmalloc will only give 
> you up to 128KB, and even that might be tricky to do
> with GFP_ATOMIC.
> 
         NO I mean the source code total require 625kB
not i require a single call of kmalloc with GFP_ATOMIC
but many calls whose total sum will be around 625kB.

> For larger chunks of memory, you can use vmalloc()
> or reserve it 
> statically at compile time.
> 
> Chris
> 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

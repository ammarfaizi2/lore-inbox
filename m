Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWFUQMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWFUQMg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWFUQMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:12:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:17981 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750813AbWFUQMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:12:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=axl/2j6Du1lufkb/XnlJg9mnjCAeLj4I4iqkpT/ViwazNkMy1bmjG7+VL3SderbWwGE/zhcHoMnqcqNAKvMX/15nzOf5Arf4lQX3GHhQnmeCcHjYEKAYKQ/x12Y6bfCGUUt95EHLREF2prDfUb2ynGrNBwRKPdBOTXegids/bLY=
Message-ID: <642640090606210912g65506825kd1921f8cfb637013@mail.gmail.com>
Date: Wed, 21 Jun 2006 10:12:29 -0600
From: "Ryan McAvoy" <ryan.sed@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: realtime-preempt for MIPS - compile problem with rwsem
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
       "Ingo Molnar" <mingo@elte.hu>, "Thomas Gleixner" <tglx@linutronix.de>
In-Reply-To: <Pine.LNX.4.58.0606211125590.29348@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <642640090606201208g31a0a57bm268910b026ccd335@mail.gmail.com>
	 <Pine.LNX.4.58.0606210354050.29673@gandalf.stny.rr.com>
	 <642640090606210804k282085efm84476af3a8fa08b1@mail.gmail.com>
	 <Pine.LNX.4.58.0606211125590.29348@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/06, Steven Rostedt wrote:

http://groups.google.com/group/linux.kernel/browse_frm/thread/1559667001b7da2d/2558b539a5adc660?lnk=st&q=realtime+preempt+mips&rnum=2&hl=en#2558b539a5adc660
> > In the more common hangs though, I get no output.
>
> That output looks like it had a deadlock on the serial output of sysrq
> key.  But that back trace looks screwy.
>

That problem actually went away with 2.6.16.  All the others remained
unfortunately.  (I was not that concerned about that one ... I can
avoid it just by not sending a sysrq ;-).  I posted it though since I
did actually have output with that hang).

>
> Perhaps you can post all the changes you made as a patch to see if
> something else is wrong.  It might also be best to see if you can get the
> latest working (2.6.17-rtX) and work your way backwards to the kernel
> version you really need.
>

I will post the other changes soon.  (I am not at the office where I
am working on this yet this morning).  I will also try 2.6.17.
Thanks.

Ryan

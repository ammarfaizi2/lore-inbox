Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131464AbQLSAjo>; Mon, 18 Dec 2000 19:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131476AbQLSAjf>; Mon, 18 Dec 2000 19:39:35 -0500
Received: from linuxcare.com.au ([203.29.91.49]:50437 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S131392AbQLSAjP>; Mon, 18 Dec 2000 19:39:15 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Eli Carter <eli.carter@inet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: generic sleeping locks? 
In-Reply-To: Your message of "Mon, 18 Dec 2000 17:08:25 MDT."
             <3A3E98E9.F68BC13A@inet.com> 
Date: Tue, 19 Dec 2000 11:06:35 +1100
Message-Id: <E148AIe-0000UM-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3A3E98E9.F68BC13A@inet.com> you write:
> Alan Cox wrote:
> > 
> > > Are there blocking lock primitives already defined somewhere in the
> > > kernel?
> > 
> > down and up are normally appropriate for this
> 
> Ungh.  Forest.  Trees.  *sigh*  Sorry for the dumb question.  
> Thanks for the reply Alan.  :)
> 
> Ok, second part of the question:  What about blocking read/write locks
> (with _interruptible variants)?

Documentation/DocBook/kernel-locking*

Rusty.
--
Hacking time.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

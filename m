Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287388AbSBDSO6>; Mon, 4 Feb 2002 13:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284138AbSBDSOt>; Mon, 4 Feb 2002 13:14:49 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:2700 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S287388AbSBDSOj>; Mon, 4 Feb 2002 13:14:39 -0500
Message-ID: <3C5ECF8C.1744549C@redhat.com>
Date: Mon, 04 Feb 2002 18:14:36 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-26beta.16smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <E16XmqC-0007lb-00@the-village.bc.nu> <3C5EC104.A3412D56@uni-mb.si> <E16Xmjc-0001uS-00@Princess> <E16XnUr-0004mf-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > What he is saying is that you can't do that, generically. Some options are
> > available at runtime through /proc, but most are not. You need to check what
> > happend back at compile time.
> 
> Right, there is a religious issue here: some core kernel hackers believe
> that it is wrong to encode kernel configuration in the kernel, and that
> is why it's not available.  Technically it is not difficult, nor is it
> difficult to make it memory-efficient.

It's silly to put it permanently in unswappable memory; putting it in 
/lib/modules/`uname -r/
somewhere does make tons of sense instead.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287840AbSBDSUL>; Mon, 4 Feb 2002 13:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286893AbSBDST7>; Mon, 4 Feb 2002 13:19:59 -0500
Received: from dsl-213-023-038-180.arcor-ip.net ([213.23.38.180]:37012 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287134AbSBDSTs>;
	Mon, 4 Feb 2002 13:19:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: arjanv@redhat.com
Subject: Re: How to check the kernel compile options ?
Date: Mon, 4 Feb 2002 19:24:33 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16XmqC-0007lb-00@the-village.bc.nu> <E16XnUr-0004mf-00@starship.berlin> <3C5ECF8C.1744549C@redhat.com>
In-Reply-To: <3C5ECF8C.1744549C@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Xnn7-0004mp-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 4, 2002 07:14 pm, Arjan van de Ven wrote:
> > > What he is saying is that you can't do that, generically. Some options are
> > > available at runtime through /proc, but most are not. You need to check what
> > > happend back at compile time.
> > 
> > Right, there is a religious issue here: some core kernel hackers believe
> > that it is wrong to encode kernel configuration in the kernel, and that
> > is why it's not available.  Technically it is not difficult, nor is it
> > difficult to make it memory-efficient.
> 
> It's silly to put it permanently in unswappable memory; putting it in 
> /lib/modules/`uname -r/
> somewhere does make tons of sense instead.

Could you show me where I suggested putting it "permanently in unswappable memory"?

-- 
Daniel

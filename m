Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289166AbSBDSBI>; Mon, 4 Feb 2002 13:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289167AbSBDSA5>; Mon, 4 Feb 2002 13:00:57 -0500
Received: from dsl-213-023-038-180.arcor-ip.net ([213.23.38.180]:24468 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289166AbSBDSAq>;
	Mon, 4 Feb 2002 13:00:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Allan Sandfeld <linux@sneulv.dk>, linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
Date: Mon, 4 Feb 2002 19:05:41 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E16XmqC-0007lb-00@the-village.bc.nu> <3C5EC104.A3412D56@uni-mb.si> <E16Xmjc-0001uS-00@Princess>
In-Reply-To: <E16Xmjc-0001uS-00@Princess>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16XnUr-0004mf-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 4, 2002 06:16 pm, Allan Sandfeld wrote:
> On Monday 04 February 2002 18:12, David Balazic wrote:
> > Alan Cox wrote:
> > > > > > How can I figure out in 5 minutes, without a kernel hacker, if
> > > > > > my linux system has the correct settings ?
> > > > >
> > > > > Use the vendor supplied kernels ?
> > > >
> > > > Yes, I am using them.
> > > > Now back to my question, how do I found out if option X is set or not ?
> > >
> > > Check the vendor supplied source package ?
> >
> > Part of the question was "in 5 minutes". Finding the install CD,
> > installing the source package, "checking" it... are more than 5 minutes.
> > Compared to checking out the kernel parameters on HP-UX, for example.
> 
> What he is saying is that you can't do that, generically. Some options are 
> available at runtime through /proc, but most are not. You need to check what 
> happend back at compile time.

Right, there is a religious issue here: some core kernel hackers believe
that it is wrong to encode kernel configuration in the kernel, and that
is why it's not available.  Technically it is not difficult, nor is it
difficult to make it memory-efficient.

-- 
Daniel

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289091AbSBDRVC>; Mon, 4 Feb 2002 12:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289124AbSBDRUx>; Mon, 4 Feb 2002 12:20:53 -0500
Received: from fw.aub.dk ([195.24.1.194]:53121 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S289091AbSBDRUg>;
	Mon, 4 Feb 2002 12:20:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld <linux@sneulv.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
Date: Mon, 4 Feb 2002 18:16:52 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E16XmqC-0007lb-00@the-village.bc.nu> <3C5EC104.A3412D56@uni-mb.si>
In-Reply-To: <3C5EC104.A3412D56@uni-mb.si>
X-BeenThere: crackmonkey@crackmonkey.org
X-Fnord: +++ath
X-Message-Flag: Message text blocked
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Xmjc-0001uS-00@Princess>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 February 2002 18:12, David Balazic wrote:
> Alan Cox wrote:
> > > > > How can I figure out in 5 minutes, without a kernel hacker, if
> > > > > my linux system has the correct settings ?
> > > >
> > > > Use the vendor supplied kernels ?
> > >
> > > Yes, I am using them.
> > > Now back to my question, how do I found out if option X is set or not ?
> >
> > Check the vendor supplied source package ?
>
> Part of the question was "in 5 minutes". Finding the install CD,
> installing the source package, "checking" it... are more than 5 minutes.
> Compared to checking out the kernel parameters on HP-UX, for example.

What he is saying is that you can't do that, generically. Some options are 
available at runtime through /proc, but most are not. You need to check what 
happend back at compile time.

-Allan

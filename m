Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281480AbRKMExZ>; Mon, 12 Nov 2001 23:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281475AbRKMEvJ>; Mon, 12 Nov 2001 23:51:09 -0500
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:49388 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S281479AbRKMEuS>; Mon, 12 Nov 2001 23:50:18 -0500
Message-ID: <3BF0A748.A68251C6@kegel.com>
Date: Mon, 12 Nov 2001 20:53:28 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Timothy D. Witham" <wookie@osdl.org>
CC: Luigi Genoni <kernel@Expansa.sns.it>, Mike Galbraith <mikeg@wen-online.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stp@osdl.org
Subject: Re: Regression testing of 2.4.x before release?
In-Reply-To: <Pine.LNX.4.33.0111041955290.30596-100000@Expansa.sns.it> 
		<3BE5F0B5.52274D07@kegel.com>
		<1004978377.1226.22.camel@wookie-laptop.pdx.osdl.net> 
		<3BEF6B1B.1E077ED9@kegel.com> <1005592054.16715.35.camel@wookie-laptop.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Timothy D. Witham" wrote:
> 
> On Sun, 2001-11-11 at 22:24, Dan Kegel wrote:
> > At some point it might be nice to also use the STP to help
> > speed gcc 3 development, too.  (I personally am really
> > looking forward to the day when I can use the same compiler
> > for both c++ and kernel.)
> 
>   Strange, I was just talking to somebody about compiler
> performance and regression issues and what sort of automation
> could be done to do that sort of testing.
> 
>   Since the STP is really a framework and just about any piece
> of software and testing environment could be worked into it.
> 
>  So I guess you could have two pieces.  One that just ran a bunch
> of compile and user level tests and then one that went in and
> checked out the compiler on a kernel tree and then ran the
> same performance tests that had been run using the "standard"
> compiler.

Go/no-go tests, where you make sure a kernel compiled with gcc 3
actually works, might be appropriate for starters.  I don't know
if that's been established yet.

>   Are you stepping forward to integrate this into STP? :-)

I wish!  Alas, tendinitis makes hacking hazardous for me for now.

- Dan

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRA2VoY>; Mon, 29 Jan 2001 16:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130765AbRA2VoP>; Mon, 29 Jan 2001 16:44:15 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:1337 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129534AbRA2VoD>; Mon, 29 Jan 2001 16:44:03 -0500
Message-ID: <3A75E3DB.C13C380F@linux.com>
Date: Mon, 29 Jan 2001 13:42:51 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jonathan Earle <jearle@nortelnetworks.com>
CC: "'Jeremy M. Dolan'" <jmd@foozle.turbogeek.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc update/fixes for sysrq.txt
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCE3@zcard00g.ca.nortel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Earle wrote:

> > On Sun, 28 Jan 2001 11:35:50 +0000, David Ford wrote:
> > > AFAIK, this hasn't ever been true.  I have never had to specifically
> > > enable it at run time.
> >
> > I was suspicious of that in the old doc but thought I'd leave it in...
> > Should have asked for feedback on it, but you caught it
> > anyway, thanks!
> >
> > Here's a patch against the first that simply removes the lines.
>
> I'd suggest leaving those lines in; I've never had it enabled by default.
> I've run Debian and Redhat systems, and both had to have the option
> specifically turned ON via startup script - simply compiling it into a
> kernel did not enable it.
>
> Jon

I suggest compiling it in and booting with init=/bin/bash, mounting /proc
and checking the value.  It is enabled by default.  A few distributions have
a boot script that enables or disables it based on the sysconfig.

-d


--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

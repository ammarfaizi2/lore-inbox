Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266855AbUBMJjo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 04:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266856AbUBMJjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 04:39:44 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:31873 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S266855AbUBMJjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 04:39:42 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Andrew Morton <akpm@osdl.org>, Giuliano Pochini <pochini@shiny.it>
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle
Date: Fri, 13 Feb 2004 17:49:19 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200402130615.10608.mhf@linuxmail.org> <XFMail.20040213095802.pochini@shiny.it> <20040213011012.12645046.akpm@osdl.org>
In-Reply-To: <20040213011012.12645046.akpm@osdl.org>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402131749.19758.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 17:10, Andrew Morton wrote:
> Giuliano Pochini <pochini@shiny.it> wrote:
> >
> > 
> > On 12-Feb-2004 Michael Frank wrote:
> > > Here is Codingstyle updated.
> > 
> > > +The limit on the length of lines is 80 columns and this is a hard limit.

Sorry, I "shortened" that line away and will add it again.

> > 
> > Well, I think this requirement is a bit silly IMHO. How many of us
> > do usually code in a 80x25 terminal screen nowadays ?

I still use 80 wide but with many more lines. I tend to be sloppy about 
code extending beyond 80, which I shall change ;)

Also bear in mind that the fundamental arguments for 80 columns are not 
related to (display) hardware capabilities, but related to clarity of code.

> > 
> 
> "I think the 90x25 requirement is silly"
> 
> "I think the 100x25 requirement is silly"
> 

> And so it goes.  You get into an xterm arms race wherein everyone has to
> make their terminal as wide as the widest guy so anyone can get any work
> done.
> 
> Yes, 80 cols sucks and the world would be a better place had CodingStyle
> mandated 96 columns five years ago.  But it didn't happen.
> 

As to "five years ago", what about review the coding style situation before 
starting 2.7:

In view of better hardware, increasing linelength a little to 96 could be 
considered without increasing the number of indentation levels.

Perhaps consider deprecating function-like macros as inline technology
is much improved.

...


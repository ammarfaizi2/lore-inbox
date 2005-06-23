Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262654AbVFWR0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbVFWR0h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 13:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVFWR0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 13:26:03 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:39622 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262637AbVFWRIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 13:08:42 -0400
Subject: Re: [ltp] Re: IBM HDAPS Someone interested?
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Knutar <jk-lkml@sci.fi>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
In-Reply-To: <200506231833.34423.jk-lkml@sci.fi>
References: <007301c575d9$77decb90$600cc60a@amer.sykes.com>
	 <42B73BB7.4030906@linuxwireless.org> <1119310501.17602.1.camel@mindpipe>
	 <200506231833.34423.jk-lkml@sci.fi>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 13:08:39 -0400
Message-Id: <1119546519.32469.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-23 at 18:33 +0300, Jan Knutar wrote:
> On Tuesday 21 June 2005 02:35, Lee Revell wrote:
> 
> > I was thinking more along the lines of figure out the io port it's
> > using, then boot windows, set an IO breakpoint in softice, then drop
> > your laptop on the bed or something.
> 
> io ports 0x2E, 0x2F and 0xED aren't assigned to anything "known"
> on other computers, are they? Someone with windows, softice and
> tendency to reach deep insights into life, the universe and everything,
> might find it fun to stare at.
> 

Now you're talking my language... nope, they aren't used on any of my
machines... hmm...  Anyone want to lend me their Thinkpad? ;-P

On a related note, I found it kind of depressing when I went to RE a
Windows driver, I got millions of hits on how to crack copy protection
on games, and only one guide to RE for Linux driver development:

http://dxr3.sourceforge.net/re.html

I'd really like to create a HOWTO, as there are some tricky aspects
(like getting your IDA Pro symbols loaded into SoftICE), and it's much
easier to find the register write routines than the document indicates.
Just grep for "inb", "outb" and friends, most likely they each appear
exactly once.

Of course, with IO breakpoints, you don't even have to do that, but the
register read/write routines are a good place to work backwards from...

Lee




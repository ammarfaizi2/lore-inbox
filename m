Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbSIPU2D>; Mon, 16 Sep 2002 16:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262856AbSIPU2D>; Mon, 16 Sep 2002 16:28:03 -0400
Received: from air-2.osdl.org ([65.172.181.6]:63622 "EHLO
	wookie-t23.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S262838AbSIPU2C>; Mon, 16 Sep 2002 16:28:02 -0400
Subject: Re: Killing/balancing processes when overcommited
From: "Timothy D. Witham" <wookie@osdl.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L.0209161610370.1857-100000@imladris.surriel.com>
References: <Pine.LNX.4.44L.0209161610370.1857-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Sep 2002 13:27:50 -0700
Message-Id: <1032208070.2318.370.camel@wookie-t23.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-16 at 12:11, Rik van Riel wrote:
> On 16 Sep 2002, Timothy D. Witham wrote:
> > On Mon, 2002-09-16 at 07:03, Rik van Riel wrote:
> 
> > > > > 1) memory is exhausted
> > > > > 2) the network driver can't allocate memory and
> > > > >    spits out a message
> > > > > 3) syslogd and/or klogd get killed
> 
> >   Not in what I had described.  Unless the page fault was for a new page
> > (just malloc'ed) it wouldn't result in the killing of the process.
> 
> Unfortunately they do. Reality doesn't quite match your
> description.
> 

  I wasn't talking about the current situation I was talking about
the pre-allocation method.

Tim

> Rik
> -- 
> Bravely reimplemented by the knights who say "NIH".
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> Spamtraps of the month:  september@surriel.com trac@trac.org
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)


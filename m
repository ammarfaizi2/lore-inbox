Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbUJ3XCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbUJ3XCp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbUJ3XB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 19:01:59 -0400
Received: from [66.35.79.110] ([66.35.79.110]:7324 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261407AbUJ3Wuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:50:37 -0400
Date: Sat, 30 Oct 2004 15:50:27 -0700
From: Tim Hockin <thockin@hockin.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Lee Revell <rlrevell@joe-job.com>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
Message-ID: <20041030225027.GA23972@hockin.org>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel> <200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua> <1099170891.1424.1.camel@krustophenia.net> <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua> <20041030222720.GA22753@hockin.org> <4184193A.3060406@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4184193A.3060406@pobox.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 06:44:10PM -0400, Jeff Garzik wrote:
> Tim Hockin wrote:
> >So you end up with the mindset of, for example, "if it's text it's XML".
> >You have to parse everything as XML, when simple parsers would be tons
> >faster and simpler and smaller.
> 
> 
> hehehe.  One of the reasons why I like XML is that you don't have to 
> keep cloning new parsers.

I'm fine with XML, when it makes sense.  In fact, I wrote an XML parser.
It's blazingly fast.  But it doesn't try to do everything for everyone.
It does just as much as I needed.  And Whn I need XML, I don;t have any
problem linking it in.  It's only a couple hundred lines of C.

What irks me is best demonstrated by this:

At OLS last year or the year before, at a talk about DBUS, someone asked
about the DBUS protocol.  When told that it was binary, they asked if
there was any advantage to that over text.  The reply "We didn't want to
link an XML parser in".

Now, I am fine with not wanting to ad bloat.  But umm, the question was
about TEXT, not XML.  They are not the same thing.  Not all text should be
XML.


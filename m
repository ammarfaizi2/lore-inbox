Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbTINNwx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 09:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbTINNwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 09:52:53 -0400
Received: from smtp.mailix.net ([216.148.213.132]:28869 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S261156AbTINNww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 09:52:52 -0400
Date: Sun, 14 Sep 2003 15:52:48 +0200
From: Alex Riesen <fork0@users.sf.net>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test5-mm1
Message-ID: <20030914135248.GA9729@steel.home>
Reply-To: Alex Riesen <fork0@users.sf.net>
References: <20030913091306.GA3658@steel.home> <200309141246.01341.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309141246.01341.arvidjaar@mail.ru>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov, Sun, Sep 14, 2003 10:46:01 +0200:
> On Saturday 13 September 2003 13:13, Alex Riesen wrote:
> > > really-use-english-date-in-version-string.patch
> > >  really use english date in version string
> >
> > -  echo \#define LINUX_COMPILE_TIME \"`LANG=C date +%T`\"
> > +  echo \#define LINUX_COMPILE_TIME \"`LC_ALL=C LANG=C date +%T`\"
> >
> > LC_ALL overrides everything, so LANG is not needed anymore. Should be:
> >
> > +  echo \#define LINUX_COMPILE_TIME \"`LC_ALL=C date +%T`\"
> 
> I need to set three! variables to make man display manpage in english not in 
> russian. I have no idea which variables all versions of date out there 
> respect and which one wins. If you are sure LC_ALL is enough for everyone - 
> so be it.
> 

$ info libc
...
Categories of Activities that Locales Affect
...
`LC_ALL'
     This is not an environment variable; it is only a macro that you
     can use with `setlocale' to set a single locale for all purposes.
     Setting this environment variable overwrites all selections by the
     other `LC_*' variables or `LANG'.



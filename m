Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265173AbTLZMfZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 07:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265175AbTLZMfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 07:35:25 -0500
Received: from ssmtp.aster.pl ([212.76.33.23]:33676 "EHLO mail1.astercity.net")
	by vger.kernel.org with ESMTP id S265173AbTLZMfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 07:35:21 -0500
Date: Fri, 26 Dec 2003 13:35:25 +0100
From: =?iso-8859-2?Q?=A3ukasz?= Osipiuk <l.osipiuk@zodiac.mimuw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Pasza <pasza@zodiac.mimuw.edu.pl>, Paulinka <ofca@astercity.net>
Subject: Re: Strange process hangs on 2.6.0
Message-ID: <20031226123525.GB31325@lucash.localdomain>
References: <20031225211556.GA26469@lucash.localdomain> <Pine.LNX.4.58.0312251809310.14452@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312251809310.14452@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Des 25, 2003 at 06:12:13PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 25 Dec 2003, [iso-8859-2] ?ukasz Osipiuk wrote:

> Fedora core 1 is reported to have a fixed bash, so if you are RH-based, 
> the easiest fix should be to just upgrade to that.

You are right, thanks. If I install the package from Fedora it seems
that everything works fine. I'm working on finding out which patch
does the job.

> > emacs draws himself in the terminal but is not responding.
> > Only SIGKILL manages to terminate it.
> 
> SIGCONT will fix it, but yeah, it's not something you want happening.

Nope. SIGCONT did not have any effect.

-- 
Lucash
mailto: l.osipiuk@zodiac.mimuw.edu.pl

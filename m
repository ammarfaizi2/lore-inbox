Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSEMJbq>; Mon, 13 May 2002 05:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310637AbSEMJbq>; Mon, 13 May 2002 05:31:46 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:48654 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S310206AbSEMJbp>; Mon, 13 May 2002 05:31:45 -0400
Date: Mon, 13 May 2002 11:31:42 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020513093142.GB13532@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020512203103.GA9087@gallifrey> <Pine.LNX.4.44.0205121836320.15555-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002, Linus Torvalds wrote:

> As an example, if the long version looks like this:
> 
> 	<jsimmons@heisenberg.transvirtual.com>
> 	        A bunch of fixes.
> 
> 	<jsimmons@heisenberg.transvirtual.com>
> 	        Pmac updates
> 
...
> 	<rmk@arm.linux.org.uk>
> 	        [PATCH] 2.5.13: vmalloc link failure
> 
> 	        The following patch fixes this, and also fixes the similar problem in
> 	        scsi_debug.c:
> 	...
> 
> The short version could look like
> 
> 	jsimmons@heisenberg.transvirtual.com:
> 		A bunch of fixes.
> 		Pmac updates
...
> 	rmk@arm.linux.org.uk:
> 		[PATCH] 2.5.13: vmalloc link failure
> 
> 	...
> 
> ie only take the first line, and merge entries with the same author.
> 
> Perl people, stand up.

I sent a first version of a Perl program to Linus, a copy of the program
is available at
http://mandree.home.pages.de/linux/kernel/lk-changelog.pl
(Yes I know the first $Log:$ entry is missing.)

It does the above, plus it has a built-in table to write a name along
with the e-mail address, so it writes something like this:

James Simmons <jsimmons@heisenberg.transvirtual.com>:
        A bunch of fixes.
        Pmac updates
        Some more small fixes.

Russell King <rmk@arm.linux.org.uk>:
        [PATCH] 2.5.13: vmalloc link failure

Of course, if BK ChangeLogs started with a 60 character summary line as
has been suggested, that'd be very useful. Something for the
BK-with-linux-kernel-HOWTO perhaps?

I can imagine letting the script look up the addresses by means of
Roland Rosenfeld's Little Brother's Data Base at a later time.
(http://www.spinnaker.de/lbdb/)

-- 
Matthias Andree

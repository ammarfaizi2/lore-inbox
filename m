Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314433AbSFTNbg>; Thu, 20 Jun 2002 09:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314444AbSFTNbg>; Thu, 20 Jun 2002 09:31:36 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:5938 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314433AbSFTNbf>; Thu, 20 Jun 2002 09:31:35 -0400
Date: Thu, 20 Jun 2002 15:32:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa3
Message-ID: <20020620133249.GG10718@dualathlon.random>
References: <20020620055933.GA1308@dualathlon.random> <20020620130511.GA8426@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020620130511.GA8426@werewolf.able.es>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 03:05:11PM +0200, J.A. Magallon wrote:
> 
> On 2002.06.20 Andrea Arcangeli wrote:
> >
> >Only in 2.4.19pre10aa3: 07_e100-1.8.38.gz
> >Only in 2.4.19pre10aa3: 08_e100-includes-1
> >Only in 2.4.19pre10aa3: 09_e100-compilehack-1
> >
> >	Merged e100 GPL driver from Intel (also make it link
> >	into the kernel).
> >
> 
> ???
> 
> Current driver is 2.0.30...
> And would not have been easier to get it from 2.5 ? You just have
> good Makefiles, instead of hacking those from Intel, that I suppose
> are prepared for building separate from kernel tree.

I was using this version in an environment and I preferred not to change
this variable because I wouldn't had time to notice if it broke, but of
course I should upgrade soon, thanks for the reminder :). For your tree
you can backout these three patches and apply a more recent version of
course.

> Or just take it from jam2...I have been using both e100 and e1000
> in the same cluster and no problem with them.
> 
> Btw, would you mind mergin also e1000...? ;).

I didn't need it in any environment, and I usually try to avoid any
driver update in -aa except in case I can test it somehow. However if
there's significant request for this I can as well add it (in particular
because it's unlikely to raise maintainance problems).

Andrea

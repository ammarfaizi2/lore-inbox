Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267602AbUJONcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267602AbUJONcL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267633AbUJONb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:31:27 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:13005 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S267602AbUJON2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:28:25 -0400
Date: Fri, 15 Oct 2004 15:28:23 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Grover <andy.grover@gmail.com>
Cc: Matthias Urlichs <smurf@smurf.noris.de>, linux-kernel@vger.kernel.org
Message-ID: <20041015132823.GA26048@wohnheim.fh-wedel.de>
References: <1097638599.2673.9668.camel@cube> <20041013092221.471f7232.ak@suse.de> <pan.2004.10.14.16.57.23.884792@smurf.noris.de> <c0a09e5c041014185545517031@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c0a09e5c041014185545517031@mail.gmail.com>
User-Agent: Mutt/1.3.28i
Subject: Re: 4level page tables for Linux II
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Rcpt-To: andy.grover@gmail.com, smurf@smurf.noris.de, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: joern@wohnheim.fh-wedel.de
X-SA-Exim-Version: 3.1 (built Son Feb 22 10:54:36 CET 2004)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 October 2004 18:55:20 -0700, Andrew Grover wrote:
> On Thu, 14 Oct 2004 18:57:24 +0200, Matthias Urlichs
> > Disagree. Rather strongly in fact.
> > 
> > It's probably OK if you already know the stuff and have been hacking
> > Linux' mm for years already, but if you try to learn how things work by
> > actually looking at the code..?
> > 
> > Just number them. Let pd1 point to pages, pd2 to pd1 entries, and so on.
> > (Level zero is the actual pages.)
> 
> I happen to agree, but surely this can be addressed at our leisure,
> after pml4 is in.
> 
> Maybe a good task for the kernel janitors, if we all agree more
> sensible names are desirable.

Please don't.  Current names may be odd, but at least they are
sufficiently different from one another.  4 names that only differ in
a single number are an invitation for typos, thinkos and similar
confusion.

Whenever I notice a mess like that in any piece of software I change
it to make the difference bigger, not smaller.  Have you ever been
slightly distracted, kept typing anyway and it compiled just fine,
creating a subtle bug? ;)

Jörn

-- 
When I am working on a problem I never think about beauty.  I think
only how to solve the problem.  But when I have finished, if the
solution is not beautiful, I know it is wrong.
-- R. Buckminster Fuller

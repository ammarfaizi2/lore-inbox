Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267519AbUJOXjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267519AbUJOXjb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 19:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267656AbUJOXjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 19:39:31 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:18832 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S267519AbUJOXj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 19:39:28 -0400
Date: Sat, 16 Oct 2004 01:39:28 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: Andrew Grover <andy.grover@gmail.com>, linux-kernel@vger.kernel.org
Message-ID: <20041015233928.GA15449@wohnheim.fh-wedel.de>
References: <1097638599.2673.9668.camel@cube> <20041013092221.471f7232.ak@suse.de> <pan.2004.10.14.16.57.23.884792@smurf.noris.de> <c0a09e5c041014185545517031@mail.gmail.com> <20041015132823.GA26048@wohnheim.fh-wedel.de> <20041015135520.GA25999@kiste>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20041015135520.GA25999@kiste>
User-Agent: Mutt/1.3.28i
Subject: Re: 4level page tables for Linux II
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Rcpt-To: smurf@smurf.noris.de, andy.grover@gmail.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: joern@wohnheim.fh-wedel.de
X-SA-Exim-Version: 3.1 (built Son Feb 22 10:54:36 CET 2004)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 October 2004 15:55:21 +0200, Matthias Urlichs wrote:
>
> Right now, so are the existing names: you have to remember which is which.

That appears to be the problem with any name.  Still, my confusion
about which is read(2) and which is write(2) is rare.

> Levels numbered 1..4 are much simpler: you only have to remember that
> the actual pages are level zero.

if and goto is much simpler, compared to while, for, do..while, else,
and whatever slipped my mind right now.  Maybe you should target the c
standard next. ;)

> The solution of your typo problem is typechecking in the compiler;
> presumably it'll warn me if I try to store a pgd3 pointer in a pgd2
> entry.

That should help somewhat, agreed.  Patches?

Jörn

-- 
Public Domain  - Free as in Beer
General Public - Free as in Speech
BSD License    - Free as in Enterprise
Shared Source  - Free as in "Work will make you..."

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286942AbRL1Rcu>; Fri, 28 Dec 2001 12:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284139AbRL1Rca>; Fri, 28 Dec 2001 12:32:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10250 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286937AbRL1RcS>; Fri, 28 Dec 2001 12:32:18 -0500
Subject: Re: State of the new config & build system
To: wingel@hog.ctrl-c.liu.se (Christer Weinigel)
Date: Fri, 28 Dec 2001 17:39:08 +0000 (GMT)
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <20011228171403.58F6636DE6@hog.ctrl-c.liu.se> from "Christer Weinigel" at Dec 28, 2001 06:14:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K0yL-0001Ad-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * make dep is only run once
> 
> Personally, I don't see this as a big problem.  Just tell people to 

I run make dep whenever I change config. Guess what - one cmp and I can
automate that as part of make. If the .config doesnt match the
.configwhendep then its time to make dep again

> That dependencies are absolute is also not a thing that has bothered me 
> too much, it's always possible to run "make dep" after moving a tree, 
> on the other hand, I don't use NFS a lot anymore, so I can see it being 
> a problem in other environments.

sed works too, as do symlinks

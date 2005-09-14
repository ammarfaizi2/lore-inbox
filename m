Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbVINQoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbVINQoO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbVINQoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:44:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39105 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030271AbVINQoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:44:13 -0400
Date: Wed, 14 Sep 2005 09:43:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
cc: Keith Owens <kaos@ocs.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
In-Reply-To: <1126674993.5681.9.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0509140938590.26803@g5.osdl.org>
References: <7255.1126583985@kao2.melbourne.sgi.com>
 <1126674993.5681.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Sep 2005, Alejandro Bonilla Beeche wrote:
> 
> Again, this is what I do:
> 
> cd linux-2.6
> git pull rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> git checkout

What does "git log" state? Do you have recent state there? (ie it should 
have dates in the "Sep 12" kind of timeframe)

Also, if you have done something earlier that updated your HEAD file
_without_ actually updating your checked out status, then "git checkout" 
may decide that it has nothing to do. You can try "git checkout -f" in 
that case.

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268802AbUIXOWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268802AbUIXOWm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 10:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268798AbUIXOWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 10:22:42 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:15591 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268802AbUIXOWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 10:22:13 -0400
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Thomas Habets <thomas@habets.pp.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040923234520.GA7303@pclin040.win.tue.nl>
References: <200409230123.30858.thomas@habets.pp.se>
	 <20040923234520.GA7303@pclin040.win.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096031971.9791.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Sep 2004 14:19:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-24 at 00:45, Andries Brouwer wrote:
> On Thu, Sep 23, 2004 at 01:23:08AM +0200, Thomas Habets wrote:
> 
> > How about a sysctl that does "for the love of kbaek, don't ever kill these 
> > processes when OOM. If nothing else can be killed, I'd rather you panic"?
> 
> An aircraft company discovered that it was cheaper to fly its planes
> with less fuel on board. The planes would be lighter and use less fuel

Chuckle. 

The rest of us just turn on "no overcommit" in /proc/sys. That way we
get told before takeoff that there isnt enough memory instead. Really
I'm astound that the default is still to pray you don't get thrown off
the plane.

Alan


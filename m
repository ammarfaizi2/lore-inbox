Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263404AbUJ2Pwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263404AbUJ2Pwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 11:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263410AbUJ2Prh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 11:47:37 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:63400 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263414AbUJ2Pqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 11:46:36 -0400
Subject: Re: [RFC] Linux 2.6.9.1-pre1 contents
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200410291107_MC3-1-8D7A-1644@compuserve.com>
References: <200410291107_MC3-1-8D7A-1644@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099060999.13098.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 29 Oct 2004 15:43:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-29 at 16:04, Chuck Ebbert wrote:
> > This is definitely wrong,
>   It just went into mainline as rev 1.87 to ide-probe.c  :(

Yes its still being discussed and revised. 

>   Your "Integrated Technology Express" addition is missing but I'm
> going to add it here.

You only need that if you have IT8212 support merged (that is in -ac5
again and activated now). It requires the taskfile and ide-disk geometry
changes but does not require all the ide locking stuff (the user
probably does for other reasons but the ide code doesnt)

Alan


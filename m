Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVCHKAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVCHKAS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 05:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVCHKAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 05:00:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38111 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261949AbVCHJ7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 04:59:47 -0500
Date: Tue, 8 Mar 2005 04:59:38 -0500
From: Alan Cox <alan@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: alan@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       luc@saillard.org, torvalds@osdl.org
Subject: Re: [PATCH] Restore PWC driver
Message-ID: <20050308095938.GA30673@devserv.devel.redhat.com>
References: <200503072216.j27MGLqR024373@hera.kernel.org> <20050308052643.GA16222@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308052643.GA16222@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 09:26:43PM -0800, Greg KH wrote:
> As it is, the coding style sucks in places, and you didn't really need
> to make it a new subdirectory (although due to the increased size of the
> driver, it's probably better now...)

Luc I assume

> And, there's no MAINTAINERS entry for who I need to bug about this
> thing.

Try the email address at the top of the files.. ?

> So, who's going to fix up:
> 	- the MAINTAINERS entry
> 	- the coding style
> 	- drop that unneeded changelog file
> 	- fix the module help text to point to the proper file (or put
> 	  the file in the proper place.)
> 	- get rid of the c++ crud in the header file
> 	- drop the "magic" nonsense
> 	- the ioctls to work on 64bit machines
> ?

Luc and I'm happy to help doing further work on it. However it's been like that
in kernel for years so it might also be a good one for the janitors to join in
on ?





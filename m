Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266199AbUGARmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUGARmo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 13:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266198AbUGARmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 13:42:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:8833 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266199AbUGARmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 13:42:43 -0400
Date: Thu, 1 Jul 2004 10:42:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
       vojtech@suse.cz, James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>
Subject: Re: [parisc-linux] Re: [PATCH] Fix the cpumask rewrite
In-Reply-To: <40E4413B.5050000@pobox.com>
Message-ID: <Pine.LNX.4.58.0407011041370.11212@ppc970.osdl.org>
References: <1088266111.1943.15.camel@mulgrave>  <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
  <1088268405.1942.25.camel@mulgrave>  <Pine.LNX.4.58.0406260948070.14449@ppc970.osdl.org>
  <20040701131158.GP698@openzaurus.ucw.cz> <1088690821.4621.11.camel@localhost.localdomain>
 <Pine.LNX.4.58.0407010908260.11212@ppc970.osdl.org> <40E4413B.5050000@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Jul 2004, Jeff Garzik wrote:
> 
> FWIW one of the major uses of bitops currently is e.g. in 
> include/linux/netdevice.h, where bitops are used for atomic selection of 
> code paths, but not spinning:

That's fine. They _are_ defined to be atomic, and as such they are perfect 
for things like that.

		Linus

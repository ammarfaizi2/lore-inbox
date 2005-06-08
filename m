Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVFHCIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVFHCIh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 22:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVFHCIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 22:08:37 -0400
Received: from ozlabs.org ([203.10.76.45]:710 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262066AbVFHCIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 22:08:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17062.21286.601768.751853@cargo.ozlabs.ibm.com>
Date: Wed, 8 Jun 2005 12:08:38 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Erik Mouw <erik@harddisk-recovery.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Linux v2.6.12-rc6
In-Reply-To: <Pine.LNX.4.58.0506070820170.2286@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
	<20050607130535.GD16602@harddisk-recovery.com>
	<Pine.LNX.4.58.0506070820170.2286@ppc970.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> The merge message that goes along with that shortlog entry is
> 
> 	Author: Linus Torvalds <torvalds@ppc970.osdl.org>
> 	Date:   Sat Jun 4 08:18:39 2005 -0700
> 
> 	    Automatic merge of 'misc-fixes' branch from
>     
> 	        rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6
> 
> which is pretty readable in the long format, but causes the shortlog to 
> pick up just the partial (largely uninteresing) first line.

This also affects gitk, which takes the first line of the commit
message as the headline.  I could make gitk take the first paragraph
(i.e. until the first blank line) as the headline but even that
wouldn't help since you put a blank line between the "Automatic merge"
line and the actual URL.  Could you leave out that blank line in
future, or do you have a better suggestion?

Paul.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265118AbUFRL4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265118AbUFRL4M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 07:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265122AbUFRL4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 07:56:11 -0400
Received: from web52902.mail.yahoo.com ([206.190.39.179]:44663 "HELO
	web52902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265118AbUFRL4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 07:56:07 -0400
Message-ID: <20040618115607.36756.qmail@web52902.mail.yahoo.com>
Date: Fri, 18 Jun 2004 13:56:07 +0200 (CEST)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Re: PROBLEM: 2.6.7 does not compile (jfs errors)
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1087403262.29041.25.camel@shaggy.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Dave Kleikamp <shaggy@austin.ibm.com> a écrit : > On Wed,
2004-06-16 at 08:39, Perlbroker wrote:
> 
> > CC [M]  fs/jfs/jfs_dtree.o
> > fs/jfs/jfs_dtree.c: In function `add_index':
> > fs/jfs/jfs_dtree.c:388: parse error before `struct'
> > fs/jfs/jfs_dtree.c:389: `temp_table' undeclared (first use
> in this function)
> > fs/jfs/jfs_dtree.c:389: (Each undeclared identifier is
> reported only once
> > fs/jfs/jfs_dtree.c:389: for each function it appears in.)
> > make[3]: *** [fs/jfs/jfs_dtree.o] Error 1
> > make[2]: *** [fs/jfs] Error 2
> > make[1]: *** [fs] Error 2
> > make[1]: Leaving directory `/usr/src/linux-2.6.7'
> 
> This was reported in another thread by Tomas Szepe.  I don't
> know why
> this sometimes compiles cleanly, but this patch should fix it:
> 

For me compiles cleanly. I have JFS with ACL enabled in kernel 
(not as a module). gcc is 3.2.3

> 
> -- 
> David Kleikamp
> IBM Linux Technology Center
> 

Calin


=====
--
A mouse is a device used to point at 
the xterm you want to type in.
Kim Alm on a.s.r.


	

	
		
Créez gratuitement votre Yahoo! Mail avec 100 Mo de stockage !
Créez votre Yahoo! Mail sur http://fr.benefits.yahoo.com/

Dialoguez en direct avec vos amis grâce à Yahoo! Messenger !Téléchargez Yahoo! Messenger sur http://fr.messenger.yahoo.com

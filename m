Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVEDTWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVEDTWS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 15:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVEDTWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 15:22:18 -0400
Received: from mailfe09.swip.net ([212.247.155.1]:33520 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261405AbVEDTWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 15:22:13 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [RFC][PATCH] update SubmittingPatches to clarify attachment
	policy
From: Alexander Nyberg <alexn@dsv.su.se>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1115230450.22718.14.camel@localhost>
References: <20050504170156.87F67CE5@kernel.beaverton.ibm.com>
	 <200505041716.j44HGPbV016851@turing-police.cc.vt.edu>
	 <1115227516.22718.4.camel@localhost>
	 <20050504175535.GT23013@shell0.pdx.osdl.net>
	 <1115230450.22718.14.camel@localhost>
Content-Type: text/plain
Date: Wed, 04 May 2005 21:21:53 +0200
Message-Id: <1115234513.2562.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ons 2005-05-04 klockan 11:14 -0700 skrev Dave Hansen:
> On Wed, 2005-05-04 at 10:55 -0700, Chris Wright wrote:
> > I agree that things are better.  But, ironically, this patch is a case
> > in point.  It's attached as text/x-patch and makes replying to and
> > commenting on patch inline more laborious.
> 
> Well, crap.
> 
> I've sent an awful lot of patches that way, and never had a negative
> reply from a maintainer or a patch commenter.
> 
> As an aside: is there a proper way to do patch text/plain attachments
> from Evolution?  Maybe we need a quick tutorial on what the best way to
> send patches is with several popular mailers.
> 

In evolution I just do new mail => insert => text file and change the
mail to preformat instead of normal formatting. I'm sure there are
settings somewhere to make this default but I don't send enough patches
(yet) to bother, the output works anyway (old patch shown below):

Index: linux-2.6/arch/x86_64/kernel/head64.c
===================================================================
--- linux-2.6.orig/arch/x86_64/kernel/head64.c	2005-04-26 11:41:43.000000000 +0200
+++ linux-2.6/arch/x86_64/kernel/head64.c	2005-04-29 11:57:46.000000000 +0200
@@ -93,9 +93,6 @@
 #ifdef CONFIG_SMP
 	cpu_set(0, cpu_online_map);
 #endif
-	/* default console: */
-	if (!strstr(saved_command_line, "console="))
-		strcat(saved_command_line, " console=tty0"); 
 	s = strstr(saved_command_line, "earlyprintk=");
 	if (s != NULL)
 		setup_early_printk(s);



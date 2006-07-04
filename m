Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWGDMOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWGDMOE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 08:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWGDMOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 08:14:04 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:34267 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932233AbWGDMOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 08:14:03 -0400
Date: Tue, 4 Jul 2006 14:09:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Minor cleanup to lockdep.c
Message-ID: <20060704120925.GA2055@elte.hu>
References: <200607041234.30350.ak@suse.de> <20060704103314.GA31568@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704103314.GA31568@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > - Use printk formatting for indentation
> > - Don't leave NTFS in the default event filter
> > 
> > Signed-off-by: Andi Kleen <ak@suse.de>
> 
> thanks!
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>

and here's two small cleanups to the cleanup [add-on patch] :-)

------------------------>
Subject: [patch] lockdep: minor cleanup to lockdep.c, #2
From: Ingo Molnar <mingo@elte.hu>

fix some minor whitespace damage introduced by the cleanup patch.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/lockdep.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -170,7 +170,7 @@ EXPORT_SYMBOL(lockdep_internal);
 static int class_filter(struct lock_class *class)
 {
 #if 0
-	/* Example */	
+	/* Example */
 	if (class->name_version == 1 &&
 			!strcmp(class->name, "lockname"))
 		return 1;
@@ -179,7 +179,7 @@ static int class_filter(struct lock_clas
 		return 1;
 #endif
 	/* Allow everything else. 0 would be filter everything else */
-	return 1;	
+	return 1;
 }
 #endif
 

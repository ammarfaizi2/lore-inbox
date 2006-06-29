Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWF2Qti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWF2Qti (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 12:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWF2Qti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 12:49:38 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:15118 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1750950AbWF2Qth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 12:49:37 -0400
Date: Thu, 29 Jun 2006 12:49:01 -0400
From: Matt LaPlante <laplam@rpi.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, zippel@linux-m68k.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>, trivial@kernel.org
Subject: Re: [PATCH] Kconfig: Typos in net/sched/Kconfig
Message-Id: <20060629124901.5f8987ff.laplam@rpi.edu>
In-Reply-To: <1151582487.23785.20.camel@localhost.localdomain>
References: <20060629022623.67ba2cbc.laplam@rpi.edu>
	<1151582487.23785.20.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 12:49:11 -0400
	(not processed: message from trusted or authenticated source)
X-Return-Path: laplam@rpi.edu
X-Envelope-From: laplam@rpi.edu
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 12:49:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 13:01:27 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Iau, 2006-06-29 am 02:26 -0400, ysgrifennodd Matt LaPlante:
> > Fix typos in net/sched/Kconfig.  And yes, its "queuing" in the dictionary.com. :)
> 
> Dictionary.com is incomplete. Please use a proper reference if you are
> going to fix "spelling" errors.
> 
> The Oxford English Dictionary lists both forms as correct.
> 
> Alan
> 

It seems many references are incomplete in some way or another.  But I don't disagree, I will try to use a more robust source of the english language (I had actually checked multiple previously, and apparently they were equally deficient).  The new patch:

-
Matt LaPlante

--

--- a/net/sched/Kconfig	2006-06-20 05:31:55.000000000 -0400
+++ b/net/sched/Kconfig	2006-06-29 02:26:33.000000000 -0400
@@ -305,7 +305,7 @@
 	tristate "Universal 32bit comparisons w/ hashing (U32)"
 	select NET_CLS
 	---help---
-	  Say Y here to be able to classify packetes using a universal
+	  Say Y here to be able to classify packets using a universal
 	  32bit pieces based comparison scheme.
 
 	  To compile this code as a module, choose M here: the
@@ -485,7 +485,7 @@
         tristate "IPtables targets"
         depends on NET_CLS_ACT && NETFILTER && IP_NF_IPTABLES
         ---help---
-	  Say Y here to be able to invoke iptables targets after succesful
+	  Say Y here to be able to invoke iptables targets after successful
 	  classification.
 
 	  To compile this code as a module, choose M here: the
@@ -537,8 +537,8 @@
 	---help---
 	  Say Y here to allow using rate estimators to estimate the current
 	  rate-of-flow for network devices, queues, etc. This module is
-	  automaticaly selected if needed but can be selected manually for
-	  statstical purposes.
+	  automatically selected if needed but can be selected manually for
+	  statistical purposes.
 
 endif # NET_SCHED



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbTIDAHa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 20:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264369AbTIDAHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 20:07:30 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:42765 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S264330AbTIDAH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 20:07:26 -0400
Date: Wed, 3 Sep 2003 21:10:01 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: Chris Wright <chrisw@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: FIX: 2.4.23-pre3 missing Makefile change
In-Reply-To: <20030903161225.B19323@osdlab.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0309032108210.30626-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Wed, 3 Sep 2003, Chris Wright wrote:

> * Marcelo Tosatti (marcelo.tosatti@cyclades.com.br) wrote:
> > 
> >   o Changed EXTRAVERSION to -pre3
> 
> I see it in bk, but it didn't seem to make it in the patch on
> kernel.org?

Damn right. Sorry for the silly mistake.

Thanks Chris

-pre3 users, please apply: 

diff -Nru a/Makefile b/Makefile
--- a/Makefile  Wed Sep  3 21:09:07 2003
+++ b/Makefile  Wed Sep  3 21:09:07 2003
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 23
-EXTRAVERSION = -pre2
+EXTRAVERSION = -pre3
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 



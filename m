Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289053AbSBMWnx>; Wed, 13 Feb 2002 17:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289047AbSBMWne>; Wed, 13 Feb 2002 17:43:34 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:7139 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S289053AbSBMWmy>; Wed, 13 Feb 2002 17:42:54 -0500
Message-Id: <200202132154.OAA03288@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Alessandro Suardi <alessandro.suardi@oracle.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [PATCH] 2.5.4, add help texts to drivers/net/pcmcia/Config.help
Date: Wed, 13 Feb 2002 15:41:10 -0700
X-Mailer: KMail [version 1.3.1]
Cc: elenstev@mesatop.com, David Hinds <dhinds@zen.stanford.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200202131712.KAA02867@tstac.esa.lanl.gov> <3C6AAC49.F099129E@mandrakesoft.com> <3C6AE72D.1010803@oracle.com>
In-Reply-To: <3C6AE72D.1010803@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 February 2002 03:22 pm, Alessandro Suardi wrote:
> Jeff Garzik wrote:
> > Thanks, patch pushed into the local queue here for 2.5.
>
> The Xircom one is wrong though - driver will be called xircom_cb.o,
>   not xircom_tulip_cb.o (that's the name of the older driver).
>
> --alessandro

Ok, here is a patch against what may be in the tree with changeset 1.316.
Thanks for noticing.
Steven

--- linux-2.5.4/drivers/net/pcmcia/Config.help.orig     Wed Feb 13 15:35:33 2002
+++ linux-2.5.4/drivers/net/pcmcia/Config.help  Wed Feb 13 15:36:13 2002
@@ -133,7 +133,7 @@

   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
-  The module will be called xircom_tulip_cb.o.  If you want to compile
+  The module will be called xircom_cb.o.  If you want to compile
   it as a module, say M here and read
   <file:Documentation/modules.txt>. If unsure, say N.

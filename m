Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265407AbUFHXI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265407AbUFHXI3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 19:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265405AbUFHXI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 19:08:29 -0400
Received: from mail.dif.dk ([193.138.115.101]:50080 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265395AbUFHXID convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 19:08:03 -0400
Date: Wed, 9 Jun 2004 01:07:18 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
       "David S. Miller" <davem@redhat.com>,
       =?ISO-8859-1?Q?Ulisses_Alonso_Camar=F3?= <uaca@alumni.uv.es>
Subject: Re: [PATCH] Trivial, add missing newline at EOF in
 Documentation/networking/packet_mmap.txt
In-Reply-To: <20040606194354.GA10081@elf.ucw.cz>
Message-ID: <8A43C34093B3D5119F7D0004AC56F4BC082C7F8D@difpst1a.dif.dk>
References: <8A43C34093B3D5119F7D0004AC56F4BC082C7F88@difpst1a.dif.dk>
 <20040606194354.GA10081@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jun 2004, Pavel Machek wrote:

> Hi!
>
> > Missing newlines at the end of files make them less pleasing to work with
> > for a number of tools that work on a line-by-line basis, and for source files
> > it will cause gcc to emit a warning. So, I desided to add that missing
> > newline to the few files in the kernel that are missing it.
> > This patch makes no functional changes at all to the kernel.
> > Patch is against 2.6.7-rc2
> >
> > Here's the patch adding a newline to
> > Documentation/networking/packet_mmap.txt
>
> Perhaps you should strip headers/lkml signature of packet_mmap.txt?
> 									Pavel

That makes sense to me, here's an updated patch against 2.6.7-rc3
(adding David S. Miller and Ulisses Alonso Camaró to the CC list since the
comment I'm removing at the top involves them (hope I got the right
persons behind "DaveM" & "Ulisses" there)) :


--- linux-2.6.7-rc3/Documentation/networking/packet_mmap.txt-orig	2004-06-09 00:58:12.000000000 +0200
+++ linux-2.6.7-rc3/Documentation/networking/packet_mmap.txt	2004-06-09 00:58:30.000000000 +0200
@@ -1,11 +1,4 @@

-DaveM:
-
-If you agree with it I will send two small patches to modify
-kernel's configure help.
-
-	Ulisses
-
 --------------------------------------------------------------------------------
 + ABSTRACT
 --------------------------------------------------------------------------------
@@ -405,8 +398,3 @@ then poll for frames.

    Jesse Brandeburg, for fixing my grammathical/spelling errors

->>> EOF
--
-To unsubscribe from this list: send the line "unsubscribe linux-net" in
-the body of a message to majordomo@vger.kernel.org
-More majordomo info at  http://vger.kernel.org/majordomo-info.html
\ No newline at end of file


--
Jesper Juhl <juhl-lkml@dif.dk>


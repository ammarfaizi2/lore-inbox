Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937827AbWLGAQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937827AbWLGAQV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 19:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937828AbWLGAQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 19:16:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:34638 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937827AbWLGAQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 19:16:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=f/2+6+ZDIPrjXqPeDO5UDPMSvyC33zFPON5W3QJm9sWhWDxOprQILVpykLHE64wN8itTUtnErmkEB6cmt5QXgODDKR6N/HUlMFwxl93K+Bx1Hv3uG/ZkSStPAqr4eAiO6zuLDKmHhC6NZxRcFxj8eaIzQFsUG8fZr2XMHy/hpJw=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Ben Nizette <ben.nizette@iinet.net.au>
Subject: Re: [PATCH] A few small additions and corrections to README
Date: Thu, 7 Dec 2006 01:18:18 +0100
User-Agent: KMail/1.9.4
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200612070045.58396.jesper.juhl@gmail.com> <45775B34.3030902@iinet.net.au>
In-Reply-To: <45775B34.3030902@iinet.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612070118.18325.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 December 2006 01:07, Ben Nizette wrote:
> Jesper Juhl wrote:
[...]
> > @@ -22,15 +22,17 @@ ON WHAT HARDWARE DOES IT RUN?
> >  
> >    Although originally developed first for 32-bit x86-based PCs (386 or higher),
> >    today Linux also runs on (at least) the Compaq Alpha AXP, Sun SPARC and
> > -  UltraSPARC, Motorola 68000, PowerPC, PowerPC64, ARM, Hitachi SuperH,
> > +  UltraSPARC, Motorola 68000, PowerPC, PowerPC64, ARM, Hitachi SuperH, Cell,
> >   
> And AVR32 as of 2.6.19 :)

Well, the list does say "(at least)" ;-)   But sure, find an add-on patch below.

> >    IBM S/390, MIPS, HP PA-RISC, Intel IA-64, DEC VAX, AMD x86-64, AXIS CRIS,
> > -  and Renesas M32R architectures.
> > +  Cris, Xtensa and Renesas M32R architectures.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff --git a/README b/README
index b656f00..c055615 100644
--- a/README
+++ b/README
@@ -24,7 +24,7 @@ ON WHAT HARDWARE DOES IT RUN?
   today Linux also runs on (at least) the Compaq Alpha AXP, Sun SPARC and
   UltraSPARC, Motorola 68000, PowerPC, PowerPC64, ARM, Hitachi SuperH, Cell,
   IBM S/390, MIPS, HP PA-RISC, Intel IA-64, DEC VAX, AMD x86-64, AXIS CRIS,
-  Cris, Xtensa and Renesas M32R architectures.
+  Cris, Xtensa, AVR32 and Renesas M32R architectures.
 
   Linux is easily portable to most general-purpose 32- or 64-bit architectures
   as long as they have a paged memory management unit (PMMU) and a port of the


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html


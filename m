Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264503AbRFTRYJ>; Wed, 20 Jun 2001 13:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264500AbRFTRX7>; Wed, 20 Jun 2001 13:23:59 -0400
Received: from email.cwcom.net ([195.44.0.104]:29965 "EHLO cwcom.net")
	by vger.kernel.org with ESMTP id <S264499AbRFTRXp>;
	Wed, 20 Jun 2001 13:23:45 -0400
From: matt.vinall@cwcom.net
Reply-to: matt.vinall@cwcom.net
To: linux-kernel@vger.kernel.org
Cc: mjv94@zepler.org.uk
Date: Wed, 20 Jun 2001 18:23:15 +0100
Subject: bigmem in 2.2.17
X-Mailer: DMailWeb Web to Mail Gateway 2.4e, http://netwinsite.com/top_mail.htm
Message-id: <3b30dc03.3e78.0@cwcom.net>
X-User-Info: 213.123.176.90
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'm trying to write a driver for a PCI card and would like to use the
bigmem patch. My development system is running 2.2.17-21mdk (Mandrake 
7.2), but as soon as I make a call to kmap() I get unresolved symbols 
bigmem_start, kmap_prot and kmap_pte. They ARE in System.map, but not 
/proc/ksyms and, indeed, there doesn't seem to be any EXPORT_SYMBOL 
directive for them in kernel/ksyms.c. I'm guessing there's something else 
I need to do but don't know what. Any ideas??

Also, does GFP_BIGMEM give me physical contiguous pages, suitable for
DMA by a PCI card? I know of GFP_DMA, but wondered if that was really
intended for ISA cards.

TIA

Matt

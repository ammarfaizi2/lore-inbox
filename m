Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287833AbSAXNpK>; Thu, 24 Jan 2002 08:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287838AbSAXNpA>; Thu, 24 Jan 2002 08:45:00 -0500
Received: from trained-monkey.org ([209.217.122.11]:5384 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S287833AbSAXNot>; Thu, 24 Jan 2002 08:44:49 -0500
From: Jes Sorensen <jes@wildopensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15440.4044.565375.681853@trained-monkey.org>
Date: Thu, 24 Jan 2002 08:44:44 -0500
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-acenic@sunsite.dk, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.3-pre4/drivers/acenic.c: pci_unmap_addr_set not defined for x86
In-Reply-To: <200201241001.CAA00304@baldur.yggdrasil.com>
In-Reply-To: <200201241001.CAA00304@baldur.yggdrasil.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Adam" == Adam J Richter <adam@yggdrasil.com> writes:

Adam> 	linux-2.5.3-pre4/drivers/acenic.c uses pci_unmap_addr_set, which
Adam> is defined for most architectures in include/asm-*/pci.h, but not
Adam> for i386.  For i386 this results in undefined references.  I
Adam> imagine that this is the result of a missed file
Adam> (include/asm-i386/pci.h?)  from an Acenic update patch.

Hi Adam

I haven't had a chance to look at it yet. The patch wasn't done by me
and whoever submitted it didn't seem to think it was worth the effort of
Cc'ing me a copy of it ;-(

I'll take a look.

Thanks,
Jes

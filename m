Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314487AbSEPSYT>; Thu, 16 May 2002 14:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314500AbSEPSYS>; Thu, 16 May 2002 14:24:18 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55313 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314487AbSEPSYR>; Thu, 16 May 2002 14:24:17 -0400
Subject: Re: Still no ramfs usage limits in 2.5.9 or 2.4.19-pre8
To: dale@farnsworth.org (Dale Farnsworth)
Date: Thu, 16 May 2002 19:11:21 +0100 (BST)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020516164926.GA16670@farnsworth.org> from "Dale Farnsworth" at May 16, 2002 09:49:26 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178Pij-0004lM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> David Gibson produced a patch about 18 months ago that added usage limits
> to ramfs.  <http://ozlabs.org/people/dgibson/dwg-ramfs.patch>
> 
> Through 2.4.10, the AC kernel series carried this patch.
> 
> Linus' kernel from 2.4.11 onward adopted only one line from the
> patch, the following attribution comment:
> 	"Usage limits added by David Gibson, Linuxcare Australia."
> 
> The usage limit code is missing, however.

Linus certainly never added it, or the address space hooks it needed. It
should have been added though definitely

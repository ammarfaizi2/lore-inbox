Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUHVVpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUHVVpH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 17:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266484AbUHVVlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 17:41:44 -0400
Received: from the-village.bc.nu ([81.2.110.252]:15248 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266473AbUHVVlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 17:41:17 -0400
Subject: Re: DTrace-like analysis possible with future Linux kernels?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040822203321.GI19768@thundrix.ch>
References: <2vipq-7O8-15@gated-at.bofh.it> <2vj2b-8md-9@gated-at.bofh.it>
	 <2vDtS-bq-19@gated-at.bofh.it> <E1ByXMd-00007M-4A@localhost>
	 <412770EA.nail9DO11D18Y@burner> <412889FC.nail9MX1X3XW5@burner>
	 <Pine.LNX.4.58.0408221450540.297@neptune.local>
	 <m37jrr40zi.fsf@zoo.weinigel.se> <20040822192646.GH19768@thundrix.ch>
	 <4128FE94.nail9U42DA799@burner>  <20040822203321.GI19768@thundrix.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093207139.25041.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 22 Aug 2004 21:38:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-22 at 21:33, Tonnerre wrote:
> > -	What are the minimum requirements for a machine to run Linux?
> 
> Intel 8086  processor with  a few ko  of RAM,  with a floppy  drive, a
> monitor and a floppy, I think. If you take only the normal kernel into
> account that will be an 80386 processor.

Minimum for an x86 kernel is about 2Mb and 386 CPU. The 8086 subset
kernel isn't really "Linux", its more an escaped insanity. For non x86
you need a bottom end mmuless 32bit processor and a couple of Mb.

There are folks driving the size down (the -tiny patches) because
2Mb for the entire system is still too large for some users.

Alan


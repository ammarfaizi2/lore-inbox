Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269414AbUICPMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269414AbUICPMg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269328AbUICPMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:12:22 -0400
Received: from the-village.bc.nu ([81.2.110.252]:13972 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269343AbUICPKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:10:01 -0400
Subject: Re: PROBLEM: Full CPU-usage on sis5513-chipset disc
	input/output-operations
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hendrik Fehr <s4248297@rcs.urz.tu-dresden.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1094216504.41386b383000b@rmc60-231.urz.tu-dresden.de>
References: <1094216504.41386b383000b@rmc60-231.urz.tu-dresden.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094220474.7975.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 03 Sep 2004 15:07:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-03 at 14:01, Hendrik Fehr wrote:
> 
> With boot option "noapic" there are no more APIC error messages. Should i add
> that boot option to my defaults in /etc/lilo.conf?

For uniprocessor machines you should avoid building with APIC support in
general anyway. A lot of systems simply don't work with APIC
uniprocessor because nobody used to use the APIC in such a
configuration. 


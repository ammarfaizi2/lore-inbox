Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbTDIO1J (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 10:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263428AbTDIO1J (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 10:27:09 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:50830 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263426AbTDIO1I (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 10:27:08 -0400
Date: Wed, 9 Apr 2003 10:35:55 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.4.21pre6 (__ide_dma_test_irq) called while not waiting
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304091038_MC3-1-33B3-570A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:


> >  Using edge-triggered interrupts with sharing is a bad idea, no?
>
> PCI IRQ lines are level triggered


 Even when /proc/interrupts says XT-PIC?  I have uniprocessor
MPS 1.4 machines and build IO-APIC kernels for them because
I thought it was safer to share interrupts that way.  The
four extra IRQ lines help, too. :)

--
 Chuck

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbTDINCe (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 09:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbTDINCe (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 09:02:34 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38043
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263301AbTDINCd (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 09:02:33 -0400
Subject: Re: 2.4.21pre6 (__ide_dma_test_irq) called while not waiting
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304090816_MC3-1-33A4-BDC1@compuserve.com>
References: <200304090816_MC3-1-33A4-BDC1@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049890509.9897.29.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Apr 2003 13:15:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-09 at 13:13, Chuck Ebbert wrote:
> ANdre Hedrick wrote:
> 
> >Does the broadcom driver have a test for who owns the intq?
> >If it is eating the hpt370's interrupt, well you already see the picture.
> 
> 
>  Using edge-triggered interrupts with sharing is a bad idea, no?

PCI IRQ lines are level triggered


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbTDILbL (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 07:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbTDILbL (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 07:31:11 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:22939
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263009AbTDILbK (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 07:31:10 -0400
Subject: Re: 2.4.21pre6 (__ide_dma_test_irq) called while not waiting
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Soeren Sonnenburg <kernel@nn7.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10304090227490.12558-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10304090227490.12558-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049885055.9901.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Apr 2003 11:44:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-09 at 10:29, Andre Hedrick wrote:
> Does the broadcom driver have a test for who owns the intq?
> If it is eating the hpt370's interrupt, well you already see the picture.

IRQ's always go to both drivers, so that cannot be happening


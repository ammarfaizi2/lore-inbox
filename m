Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTFBQKx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 12:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTFBQKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 12:10:52 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18663
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262601AbTFBQKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 12:10:50 -0400
Subject: Re: ide problem - is this a known problem, or is the disk dead?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Murray <rob@mur.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030601222857.GA1116@mur.org.uk>
References: <20030601222857.GA1116@mur.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054567577.7771.42.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jun 2003 16:26:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-01 at 23:28, Robert Murray wrote:
> Jun  1 06:28:00 r2d2 kernel: hdc: dma_timer_expiry: dma status == 0x21
> Jun  1 06:28:10 r2d2 kernel: hdc: timeout waiting for DMA
> Jun  1 06:28:10 r2d2 kernel: hdc: timeout waiting for DMA
> Jun  1 06:28:10 r2d2 kernel: hdc: (__ide_dma_test_irq) called while not waiting
> Jun  1 06:28:10 r2d2 kernel: hdc: status timeout: status=0xd0 { Busy }
> Jun  1 06:28:10 r2d2 kernel:
> Jun  1 06:28:10 r2d2 kernel: hdc: drive not ready for command
> Jun  1 06:28:40 r2d2 kernel: ide1: reset timed-out, status=0xd0
> Jun  1 06:28:40 r2d2 kernel: hdc: status timeout: status=0xd0 { Busy }
> Jun  1 06:29:11 r2d2 kernel:

Its hard to tell if thats a dead disk or just terminally confused. The
drive stopped taking to us, set itself Busy and never came back even
after we tried to reset it.



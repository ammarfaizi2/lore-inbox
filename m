Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267725AbUG3Pqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267725AbUG3Pqz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 11:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267723AbUG3Ppv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 11:45:51 -0400
Received: from the-village.bc.nu ([81.2.110.252]:28065 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267724AbUG3PpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 11:45:04 -0400
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <410A631B.3020600@colorfullife.com>
References: <410A631B.3020600@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091198544.3587.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 30 Jul 2004 15:42:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-07-30 at 16:02, Manfred Spraul wrote:
> Btw, what's the preferred approach to clear the pci master bit: 
> forcedeth writes to freed buffers after ifdown right now. I'll add a 
> reset into the _close function, but disabling the master bit is probably 
> better.

Can you stick the forcedeth chip into S3 state on close - that might be
more direct providing you can get it back again


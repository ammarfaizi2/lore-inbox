Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbULTU6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbULTU6a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 15:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbULTU63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 15:58:29 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:38273 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261639AbULTU60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 15:58:26 -0500
Subject: Re: Linux 2.6.9-ac16
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Ross <chris@tebibyte.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <41C6FB79.8030101@tebibyte.org>
References: <41C2FF09.5020005@tebibyte.org>
	 <1103222616.21920.12.camel@localhost.localdomain>
	 <1103349675.27708.39.camel@tglx.tec.linutronix.de>
	 <41C448BB.1020902@tmr.com>
	 <Pine.LNX.4.61.0412181606050.21338@yvahk01.tjqt.qr>
	 <1103554123.30268.19.camel@localhost.localdomain>
	 <41C6FB79.8030101@tebibyte.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103572475.31542.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Dec 2004 19:54:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-20 at 16:19, Chris Ross wrote:
> What sort of reasonably OK? My experience on my 64MB P2-350 Dell 
> Optiplex is that 2.6.9-acXX will kill things off at random even when the 
> machine isn't out of memory. If you have any particular test cases you 
> would like run just ask, I understand that some of the difficulty is 
> that the VM developers have machines plenty big enough not to suffer the 
> problems.

I normally test down to about 100Mbyte but not lower. The 2.6.9-ac15
tree introduced Marcelo's suggested fix for the VM writeout oom cases.


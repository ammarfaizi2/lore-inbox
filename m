Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262795AbVD2Pbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbVD2Pbz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 11:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbVD2Pbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 11:31:55 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:56790 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262795AbVD2Pbx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 11:31:53 -0400
Subject: Re: ATA port addresses
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: john doe <catcowcrow@yahoo.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050429150011.62598.qmail@web60211.mail.yahoo.com>
References: <20050429150011.62598.qmail@web60211.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114788639.18330.293.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 29 Apr 2005 16:30:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-04-29 at 16:00, john doe wrote:
> What I need to know is the port address space for the
> ATA device.  Specifically the port address space of
> the command bloc registers.

Its architecture and board dependent. Linux will let you issue IDE
taskfile command blocks via ioctls so you can avoid poking the hardware
(and poking the hardware will upset the ide driver..)



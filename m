Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262958AbVD2UVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbVD2UVx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbVD2UUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:20:35 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:60377 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262919AbVD2UT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:19:26 -0400
Subject: Re: ATA port addresses
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: john doe <catcowcrow@yahoo.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050429153738.78730.qmail@web60214.mail.yahoo.com>
References: <20050429153738.78730.qmail@web60214.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114805887.24687.300.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 29 Apr 2005 21:18:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-04-29 at 16:37, john doe wrote:
> Thank you for the prompt reply!
> 
> I'll look at this option closer.  Is there a way to
> bypass the IDE driver though? 

Write your own kernel 8) There isn't really a way to bypass it and since
you rely on the kernel for functionality like mmap you rely on it for
trust anyway. More pressingly you need DMA functionality for some
hardware and the newer devices are all getting very clever and sometimes
very unique in their interfacing


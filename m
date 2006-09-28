Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161355AbWI1WtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161355AbWI1WtT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 18:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161357AbWI1WtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 18:49:19 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41658 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161355AbWI1WtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 18:49:18 -0400
Subject: Re: PCI bridge missing
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luke-Jr <luke@dashjr.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200609281624.16082.luke@dashjr.org>
References: <200609281624.16082.luke@dashjr.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 29 Sep 2006 00:14:15 +0100
Message-Id: <1159485255.13029.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-09-28 am 16:24 -0500, ysgrifennodd Luke-Jr:
> However, this bridge is completely ignored and unseen by Linux. It does not 
> show up in lspci or dmesg (as far as I can tell) at all. The daughterboard is 
> plugged in, and the PCI cards on it are powered.

lspci -vvxxx would be interesting

Linux on PC assumes the BIOS did the work needed so if there is some
custom "enabler" driver in the Windows for it that might explain
problems.


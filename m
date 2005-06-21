Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVFUKEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVFUKEJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 06:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVFUKEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 06:04:09 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:10403 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262100AbVFUJyu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 05:54:50 -0400
Subject: Re: Internet RFCs supported by Linux TCP/IP stack
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: helen monte <hzmonte@hotmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <BAY102-F332D3FBA5C173A057F82D5A0E80@phx.gbl>
References: <BAY102-F332D3FBA5C173A057F82D5A0E80@phx.gbl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119347541.3325.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Jun 2005 10:52:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-06-21 at 06:01, helen monte wrote:
> I posted an updated version of this inquiry with the Mentat list to 
> linux-net@VGER.KERNEL.ORG under the topic "List of Internet RFCs supported 
> by Linux TCP/IP implementation?"
> http://groups-beta.google.com/group/mlist.linux.net/browse_frm/thread/9998321cb3ddf940/5012a6cd55e8b17e#5012a6cd55e8b17e
> 

The kernel source has notes on various things supported but not that I
am aware of a neat list (and in my experience people will claim bogus
ones too - eg many vendors claim to fully support RFC1122, which
requires you stack can leap tall buildings in a single bound).

For the higher level stuff like OSPF, BGP you need to look at user space
packages like quagga because they are not implemented by the kernel in
the Linux case but by user space applications.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268284AbUIBM0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268284AbUIBM0c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 08:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268283AbUIBM0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 08:26:32 -0400
Received: from the-village.bc.nu ([81.2.110.252]:6030 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268284AbUIBM0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 08:26:30 -0400
Subject: Re: [PATCH] net/ipv4 for Source VIPA support, kernel BK Head
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: lkml@einar-lueck.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200409021420.46785.elueck@de.ibm.com>
References: <200409021401.42255.elueck@de.ibm.com>
	 <1094123102.4996.10.camel@localhost.localdomain>
	 <200409021420.46785.elueck@de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094124266.4970.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 12:24:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-02 at 13:20, Einar Lueck wrote:
> You. As we pointed out in the other part of the mail iptables NAT is not an option 
> for the relevant customers.

You've failed as far as I can see to explain why NAT doesn't do the
right thing in this case. I don't care whether the customers like it, I
care whether it works. If it works then we don't need to add junk to the
kernel. If it works but is hard to configure then its an opportunity to
write a nice tool to manage it.


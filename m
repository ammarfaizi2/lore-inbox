Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbVHMA30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbVHMA30 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 20:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVHMA30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 20:29:26 -0400
Received: from mail.dvmed.net ([216.237.124.58]:45485 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750744AbVHMA3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 20:29:25 -0400
Message-ID: <42FD3EDF.7050809@pobox.com>
Date: Fri, 12 Aug 2005 20:29:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brett Russ <russb@emc.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.13-rc6] PCI/libata INTx cleanup
References: <20050803204709.8BA0720B06@lns1058.lss.emc.com> <42FBA08C.5040103@pobox.com> <20050812171043.CF61020E8B@lns1058.lss.emc.com> <20050812182253.GA7842@suse.de> <42FD14E9.8060502@pobox.com> <20050812224303.F40A820E94@lns1058.lss.emc.com>
In-Reply-To: <20050812224303.F40A820E94@lns1058.lss.emc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett Russ wrote:
> Simple cleanup to eliminate X copies of the pci_enable_intx() function
> in libata.  Moved ahci.c's pci_intx() to pci.c and use it throughout
> libata and msi.c.
> 
> Signed-off-by: Brett Russ <russb@emc.com>

Looks good to me.

Greg, do you want to queue this (since it touches PCI), or should I 
(since it touches SATA drivers)?

	Jeff




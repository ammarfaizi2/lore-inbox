Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbWFNXg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbWFNXg7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 19:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWFNXg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 19:36:59 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:57298 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965036AbWFNXg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 19:36:58 -0400
Message-ID: <44909D97.1060106@garzik.org>
Date: Wed, 14 Jun 2006 19:36:55 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Mike Miller <mike.miller@hp.com>, iss_storagedev@hp.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/7] CCISS: disable device when returning failure
References: <200606141707.27404.bjorn.helgaas@hp.com> <200606141708.33625.bjorn.helgaas@hp.com>
In-Reply-To: <200606141708.33625.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:
> If something fails after we call pci_enable_device(), we should call
> pci_disable_device() before returning the failure.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

ACK patches 1-2



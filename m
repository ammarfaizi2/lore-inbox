Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVFGSAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVFGSAm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 14:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVFGSAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 14:00:42 -0400
Received: from mail.dvmed.net ([216.237.124.58]:24270 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261949AbVFGSAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 14:00:38 -0400
Message-ID: <42A5E0BF.8000103@pobox.com>
Date: Tue, 07 Jun 2005 14:00:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: stupid SATA questions
References: <10d4b7cd189d7b661a84e765ab8cce93@freescale.com>
In-Reply-To: <10d4b7cd189d7b661a84e765ab8cce93@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala wrote:
> These questions were posed to me and I was hoping someone would have 
> better knowledge about the works and usage of SATA then I do.  All of 
> these questions are around understanding how important the performance 
> of PIO mode is.
> 
> How often would one run in PIO mode?  Why would one run in PIO mode?

Never.  No idea.  :)

Unless you have a broken device, or a command that cannot work with DMA 
(such as IDENTIFY DEVICE), PIO mode is quite pointless.  It is emulated 
under SATA, turned into FIS's on the SATA bus.

	Jeff




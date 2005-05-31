Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVEaQzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVEaQzL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVEaQvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:51:08 -0400
Received: from mail.dvmed.net ([216.237.124.58]:22913 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261963AbVEaQt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:49:26 -0400
Message-ID: <429C958F.7090700@pobox.com>
Date: Tue, 31 May 2005 12:49:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA NCQ #3
References: <20050531124659.GB1530@suse.de> <429C86AD.4050605@pobox.com> <429C90DE.3000106@tls.msk.ru>
In-Reply-To: <429C90DE.3000106@tls.msk.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> Jeff Garzik wrote:
> []
> 
>> 
>> struct ahci_host_priv {
>> 	unsigned long		flags;
>>+	unsigned int		have_msi; /* is PCI MSI enabled? */
> 
> 
> BTW, can `have_msi' be just another bit in the `flags' field?

Yes, that would be a good cleanup to make.

Wanna submit a patch adding HOST_CAP_MSI bit?

	Jeff




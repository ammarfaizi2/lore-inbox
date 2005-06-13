Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVFMTeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVFMTeQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 15:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVFMTeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 15:34:16 -0400
Received: from mail.dvmed.net ([216.237.124.58]:18916 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261217AbVFMTeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 15:34:13 -0400
Message-ID: <42ADDFA5.6000904@pobox.com>
Date: Mon, 13 Jun 2005 15:33:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: torvalds@osdl.org, linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix do_sync_(read|write) to properly handle aio retries
References: <20050613181857.GA11285@kvack.org>
In-Reply-To: <20050613181857.GA11285@kvack.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> When do_sync_(read|write) encounters an aio method that makes use of the 
> retry mechanism, they fail to correctly retry the operation.  This fixes 
> that by adding the appropriate sleep and retry mechanism.

Don't forget to send patches to akpm@osdl.org as well.  He's evolved 
into the main collector of random patches, as well as being the 2.6 
series maintainer.

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161244AbVKRVJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161244AbVKRVJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161246AbVKRVJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:09:19 -0500
Received: from mailhost.u-strasbg.fr ([130.79.200.152]:65229 "EHLO
	mailhost.u-strasbg.fr") by vger.kernel.org with ESMTP
	id S1161243AbVKRVJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:09:18 -0500
Message-ID: <437E421B.5060703@crc.u-strasbg.fr>
Date: Fri, 18 Nov 2005 22:05:31 +0100
From: Philippe Pegon <Philippe.Pegon@crc.u-strasbg.fr>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051016)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mikem <mikem@beardog.cca.cpqcorp.net>
CC: akpm@osdl.org, axboe@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/3] cciss: bug fix for BIG_PASS_THRU
References: <20051118164112.GA14937@beardog.cca.cpqcorp.net>
In-Reply-To: <20051118164112.GA14937@beardog.cca.cpqcorp.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0 (mailhost.u-strasbg.fr [IPv6:2001:660:2402::152]); Fri, 18 Nov 2005 22:07:18 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikem wrote:
> Patch 2 of 3
> 
> Applications using CCISS_BIG_PASSTHRU complained that the data written
> was zeros.  The code looked alright, but it seems that copy_from_user 
> already does a memset on the buffer. Removing it from the pass-through
> fixes the apps.
> 
> Please consider this for inclusion.

thanks a lot

--
Philippe Pegon

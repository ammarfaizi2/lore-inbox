Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161038AbVKQAHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbVKQAHx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbVKQAHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:07:53 -0500
Received: from ns2.g-housing.de ([81.169.133.75]:50309 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S1161031AbVKQAHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:07:50 -0500
Message-ID: <437BC98E.9020002@g-house.de>
Date: Thu, 17 Nov 2005 01:06:38 +0100
From: Christian <evil@g-house.de>
User-Agent: Mail/News 1.6a1 (Windows/20051004)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: netdev@vger.kernel.org
Subject: Re: 2.6.15-rc1: NET_CLS_U32 not working?
References: <437BBC59.70301@g-house.de> <20051116235813.GS5735@stusta.de>
In-Reply-To: <20051116235813.GS5735@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 0546-3, 16.11.2005), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk schrieb:
> 
> I'm assuming you are trying to insert the new module in your old kernel?

yes, i tried to "modprobe" the compiled cls_u32 module. but the "make 
modules" errors are there anyway. i tried to compile a fresh 2.6.15-rc1 
on a different machine (where i can't do "modprobe") and the errors were 
there too: http://nerdbynature.de/bits/sheep/2.6.15-rc1/make-modules.log

> This is one of the unfortunate but hardly avoidable cases where adding a 
> module requires installing a new kernel.

despite of the errors on "make modules" i'll reboot with the "new" 
kernel asap.

> BTW: Please Cc netdev@vger.kernel.org on networking issues.

ok, will do that.


thank you,
Christian.
-- 
BOFH excuse #442:

Trojan horse ran out of hay

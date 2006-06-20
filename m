Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWFTPpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWFTPpn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 11:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWFTPpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 11:45:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:59045 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751344AbWFTPpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 11:45:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=K+bjv2Ivt/x4SdNO5iW/sSxOOgKFtAQKmuINZQsF3FPYJ270dYqaOHu3Sn0YPk69Y9bWkLlJxidLVtKPrCmFASC6RoW1yVKpGZNztJF2SFigSVFogUsHayW/cEOSny43KDys5XvjfQjcJ8RePPubPbijJl2aPB8Ayu0iTgvB2p0=
Message-ID: <44981823.2050005@gmail.com>
Date: Tue, 20 Jun 2006 17:45:16 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Al Boldi <a1426z@gawab.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Add VIA chipset IDs for drm detection
References: <200606201816.08768.a1426z@gawab.com> <449817A4.4090408@gmail.com>
In-Reply-To: <449817A4.4090408@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jiri Slaby napsal(a):
> Al Boldi napsal(a):
>> Allow drm detection of new VIA chipsets.
>>
>> Signed-off-by: Al Boldi <a1426z@gawab.com>
>> --
>> --- drivers/char/drm/drm_pciids.h.old	2006-06-19 01:34:48.000000000 +0300
>> +++ drivers/char/drm/drm_pciids.h	2006-06-19 13:36:49.000000000 +0300
>> @@ -227,6 +227,9 @@
>>  	{0x1106, 0x3122, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
>>  	{0x1106, 0x7205, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
>>  	{0x1106, 0x3108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
>> +	{0x1106, 0x3157, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
>> +	{0x1106, 0x3344, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
>> +	{0x1106, 0x7204, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
>>  	{0, 0, 0}
> 
> Don't you want to post a patch converting all that lines to use PCI_DEVICE()
> (and without backslashes)?

Hrm, let backslashes be.

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E

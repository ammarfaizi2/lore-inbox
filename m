Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWFTPn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWFTPn2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 11:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWFTPn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 11:43:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:25504 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751302AbWFTPn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 11:43:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=EQAw7deaiyYd0ckWbICxhlyLZkO0gpM33tF1WRDjkO4csW2fJkxRpxhAwe0e7yGQLfz0pPNMbC27qJcXPqJMxzxl4zb2u8qAG4IOEGMAldEWhpAgUafdUbsn8ZW4ckwZZsLCa6GHBq75BSmw2VnhJLiq0uQ8QMwUxWpCGKSns1M=
Message-ID: <449817A4.4090408@gmail.com>
Date: Tue, 20 Jun 2006 17:43:09 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Add VIA chipset IDs for drm detection
References: <200606201816.08768.a1426z@gawab.com>
In-Reply-To: <200606201816.08768.a1426z@gawab.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi napsal(a):
> Allow drm detection of new VIA chipsets.
> 
> Signed-off-by: Al Boldi <a1426z@gawab.com>
> --
> --- drivers/char/drm/drm_pciids.h.old	2006-06-19 01:34:48.000000000 +0300
> +++ drivers/char/drm/drm_pciids.h	2006-06-19 13:36:49.000000000 +0300
> @@ -227,6 +227,9 @@
>  	{0x1106, 0x3122, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
>  	{0x1106, 0x7205, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
>  	{0x1106, 0x3108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
> +	{0x1106, 0x3157, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
> +	{0x1106, 0x3344, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
> +	{0x1106, 0x7204, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
>  	{0, 0, 0}

Don't you want to post a patch converting all that lines to use PCI_DEVICE()
(and without backslashes)?

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E

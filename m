Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbVAUVXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbVAUVXv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVAUVXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:23:51 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:710 "EHLO webmail.tiscali.de")
	by vger.kernel.org with ESMTP id S262519AbVAUVWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:22:38 -0500
Message-ID: <41F1729A.6000709@tiscali.de>
Date: Fri, 21 Jan 2005 22:22:34 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: modules strip
References: <5F106036E3D97448B673ED7AA8B2B6B301ACD8F7@scl-exch2k.phoenix.com>
In-Reply-To: <5F106036E3D97448B673ED7AA8B2B6B301ACD8F7@scl-exch2k.phoenix.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aleksey Gorelov wrote:

>Hi,
>
>  I'm trying to strip modules a bit (2.6, x86) using
>
>strip -R .not -R .comment --strip-unneeded module.ko
>
>  It seems to keep intact relocation & ksymtab symbols, tested on my
>configuration and seems to reduce the overall size for about 10-15%
>(usefull for embedded). Does anybody know if there is any pitfalls with
>that ?
>
>Thanks,
>Aleks.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hi!
Why should there be a pitfall, you just strip some usualy not needed 
information. But maybe this causes problems with functions or parts of 
the Kernel which need this information.

Matthias-Christian Ott

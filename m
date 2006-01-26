Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWAZWij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWAZWij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWAZWij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:38:39 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:10229 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964946AbWAZWij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:38:39 -0500
Message-ID: <43D94F62.2090707@sirrix.de>
Date: Thu, 26 Jan 2006 23:38:26 +0100
From: Oskar Senft <osk-lkml@sirrix.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
       linux-kernel@vger.kernel.org
Subject: Re: USB host pci-quirks
References: <0EF82802ABAA22479BC1CE8E2F60E8C3AA3641@scl-exch2k3.phoenix.com>
In-Reply-To: <0EF82802ABAA22479BC1CE8E2F60E8C3AA3641@scl-exch2k3.phoenix.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:701b7ca108cfd083b467aa547eda228f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Aleksey,

thank you for your e-mail!

>>Is there a special need, that the "drivers/usb/host/pci-quirks.c" is
>>compiled into the kernel even if USB support is disabled?
> 
>   Yes, there is. USB handoff is necessary even if USB support is
> disabled completely in kernel. In fact, initially early usb handoff code
> was under pci, but since USB drivers do handoff anyway, it was decided
> to move everything into usb with a goal of merging them together. 
>   Just search for USB handoff in kernel archives.

I see ... but as David Brownell already stated on Thu Sep 02 2004 -
20:07:57 EST:
For backwards compatibility, the early reset should not be the
default. There aren't many systems where it's a problem.

What happened to that argument?

Regards,
Oskar.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWGCWxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWGCWxH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWGCWxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:53:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:12467 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932174AbWGCWxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:53:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=b2O2OOunVfdAcct+M5VGL0UUYI0NA1dIx1z6gPqEpgcVGHNeB4iZpXhPeeXViyxeWzONkHikX+2EaRHNjNvyd/bS/DISw02XzTXKa27NVJr3KV/0hiQ4wny5a0i08dv9ZEV0rvxrfNTCerTLImlh3fOB3awA3+kISR6/yGxxLbA=
Message-ID: <44A99FE5.6020806@gmail.com>
Date: Tue, 04 Jul 2006 00:53:02 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>,
       linux-pm@osdl.org
Subject: Re: swsusp regression
References: <44A99DFB.50106@gmail.com>
In-Reply-To: <44A99DFB.50106@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby napsal(a):
> Hello,
> 
> when suspending machine with hyperthreading, only Freezing cpus appears and then

Note: suspending to disk; done by:
echo reboot > /sys/power/disk
echo disk > /sys/power/state

> it loops somewhere. I tried to catch some more info by pressing sysrq-p. Here
> are some captures:
> http://www.fi.muni.cz/~xslaby/sklad/03072006074.gif
> http://www.fi.muni.cz/~xslaby/sklad/03072006075.gif

One more from some previous kernels (cutted sysrq-t):
http://www.fi.muni.cz/~xslaby/sklad/22062006046.jpg

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E

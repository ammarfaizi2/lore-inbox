Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWGCWpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWGCWpE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWGCWpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:45:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:26270 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751172AbWGCWpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:45:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=GOMpTy+1kmYxUF11hvo+nSkTNakGPYrBxy853JI8k3EagGmRRvtKlzFQQX3+Y7803PnYK7JKf8XbpWqaHDj2LKonHceLZO0Y0iz9x4Pr+ALP4dHzk+jKodSDAC3enNfZWY2IyQwIq6EiKasspjTlRO65TIkv6tUCX28aNzvTkKQ=
Message-ID: <44A99DFB.50106@gmail.com>
Date: Tue, 04 Jul 2006 00:44:52 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>,
       linux-pm@osdl.org
Subject: swsusp regression
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when suspending machine with hyperthreading, only Freezing cpus appears and then
it loops somewhere. I tried to catch some more info by pressing sysrq-p. Here
are some captures:
http://www.fi.muni.cz/~xslaby/sklad/03072006074.gif
http://www.fi.muni.cz/~xslaby/sklad/03072006075.gif

It was working just perfect in 2.6.17-rcX-mmXs, but from 2.6.17-mmX times (maybe
X>=3) it doesn't sleep anymore -- I may be lucky sometimes, and it is successful
also in 2.6.17-mm5, but most time everything I get is Freezing and nothing is
frozen but fishes in my fridge.

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E

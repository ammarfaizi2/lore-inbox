Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVCTLtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVCTLtp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 06:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVCTLto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 06:49:44 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:35421 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S262135AbVCTLtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 06:49:43 -0500
Message-ID: <423D6353.5010603@tls.msk.ru>
Date: Sun, 20 Mar 2005 14:49:39 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bodo Eggert <7eggert@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11.2][RFC] printk with anti-cluttering-feature
References: <Pine.LNX.4.58.0503200528520.2804@be1.lrz>
In-Reply-To: <Pine.LNX.4.58.0503200528520.2804@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> (I hope I avoided all spam-keywords this time, my previous mails didn't 
>  seem to make it)
> (please CC me on reply)
> 
> Issue:
> 
> On some conditions, the dmesg is spammed with repeated warnings about the
> same issue which is neither critical nor going to be fixed. This may
> result in losing the boot messages or missing other important messages.

There's printk_ratelimit() already, used in quite several places in kernel
(or net_ratelimit() for net/* stuff).  See also Documentation/sysctl/kernel.txt,
search for printk_ratelimit.  JFYI.

/mjt

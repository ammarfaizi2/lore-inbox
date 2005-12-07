Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbVLGR3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbVLGR3z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 12:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVLGR3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 12:29:55 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:33685 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750830AbVLGR3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 12:29:54 -0500
Message-ID: <43971BD5.6040601@droids-corp.org>
Date: Wed, 07 Dec 2005 18:28:53 +0100
From: Olivier MATZ <zer0@droids-corp.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051001)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-i386 : config.h should not be included out of kernel
References: <4395F405.9010107@droids-corp.org> <200512062211.40142.arnd@arndb.de>
In-Reply-To: <200512062211.40142.arnd@arndb.de>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Just drop that line completely, including linux/config.h is no longer 
> necessary.

You're right, including linux/config.h is not necessary because every
file that includes asm/param.h also includes the linux/config.h directly
or indirectly.

But in my opinion, as we use CONFIG_HERTZ in param.h, we should keep the
include of config.h.

Olivier

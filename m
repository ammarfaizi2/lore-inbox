Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbUKHHsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbUKHHsx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 02:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbUKHHsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 02:48:53 -0500
Received: from mail.convergence.de ([212.227.36.84]:57059 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S261770AbUKHHsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 02:48:38 -0500
Message-ID: <418F24AC.7020202@linuxtv.org>
Date: Mon, 08 Nov 2004 08:47:56 +0100
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: kraxel@bytesex.org, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] saa7146 cleanups
References: <20041107175751.GQ14308@stusta.de>
In-Reply-To: <20041107175751.GQ14308@stusta.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07.11.2004 18:57, Adrian Bunk wrote:
> The patch below contains the following saa7146 cleanups:
> - make needlessly global code static
> - remove unused code

Thanks!

> Please comment on this, especially if patches for in-kernel uses of 
> currently unused code are pending.

saa7146_set_gpio() should really be used by saa7146 based device 
drivers, but isn't at the moment.

I committed your patches to the LinuxTV.org CVS repository with minor 
changes. Unfortunately, my next patchset is already waiting to be pushed 
to Linus and Andrew, so your patches won't go into mainline immediately.

CU
Michael.

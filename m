Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbUKHHeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbUKHHeh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 02:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUKHHef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 02:34:35 -0500
Received: from mail.convergence.de ([212.227.36.84]:47581 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S261768AbUKHHeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 02:34:19 -0500
Message-ID: <418F2151.6030800@linuxtv.org>
Date: Mon, 08 Nov 2004 08:33:37 +0100
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-dvb-maintainer] [2.6 patch] some DVB cleanups
References: <20041107121047.GE14308@stusta.de>
In-Reply-To: <20041107121047.GE14308@stusta.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07.11.2004 13:10, Adrian Bunk wrote:
> The patch below does some cleanuos under drivers/media/dvb/ .
> Most of them are:
> - make needlessly global code static
> - remove unused code

Thanks for your work!

> Most interesting might the the changes to bt878.c:
> Why did you export the init/exit functions of this module?

I don't know. Before Gerd Knorr stepped in an helped to integrate the 
bt8xx based driver into bttv there were several approaches to have these 
driver co-exist with bttv. I think these are remains of such an 
approach. Don't worry. 8-)

> Please review and comment on this patch.

I integrated it into the LinuxTV.org CVS repository. These changes will 
go into mainline with my next patchset.

CU
Michael.

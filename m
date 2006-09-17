Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbWIQRGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbWIQRGo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 13:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbWIQRGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 13:06:44 -0400
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:20750 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S965027AbWIQRGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 13:06:44 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: devzero@web.de
Subject: Re: show all modules which taint the kernel ?
Date: Sun, 17 Sep 2006 18:06:45 +0100
User-Agent: KMail/1.9.4
Cc: Dave Jones <davej@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org
References: <1313891898@web.de>
In-Reply-To: <1313891898@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609171806.45215.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 September 2006 10:34, devzero@web.de wrote:
> if there is a "contaminant" inside the kernel, why should one see this only
> when it`s being inserted (i.e. usually at boot time) ?
>
> i don`t know about the "nvidia(P)..." thing, but i would find it really
> useful to be able to easily distinguish between the "good" and the "not
> belonging to this kernel" modules.
>
> i have seem several discussions about "modules which taint the kernel are
> evil" - so why not pillory them by listing appropriate information with
> lsmod ?

I think the point being made is that we don't want to confuse this with 
vendors disclaiming support for non-shipped kernel modules. Vanilla kernels 
shouldn't consider GPL modules to be "unsupported" just because they aren't 
shipped or "digitally signed"; however we certainly should be highlighting 
the use of proprietary modules (which are obviously impossible to debug).

I agree with Lee, there should be some more black marks on proprietary drivers 
than there are currently.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.

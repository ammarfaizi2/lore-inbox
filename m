Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUEaL4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUEaL4E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 07:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbUEaL4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 07:56:00 -0400
Received: from mail013.syd.optusnet.com.au ([211.29.132.67]:14730 "EHLO
	mail013.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264396AbUEaLy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 07:54:28 -0400
From: Con Kolivas <kernel@kolivas.org>
To: aris@cathedrallabs.org (Aristeu Sergio Rozanski Filho)
Subject: Re: [PATCH] Autoregulated VM swappiness
Date: Mon, 31 May 2004 21:54:15 +1000
User-Agent: KMail/1.6.1
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <200405302330.48595.kernel@kolivas.org> <20040531115009.GG2159@cathedrallabs.org>
In-Reply-To: <20040531115009.GG2159@cathedrallabs.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405312154.15592.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2004 21:50, Aristeu Sergio Rozanski Filho wrote:
> Hi Con,
>
> +               .ctl_name       = VM_AUTO_SWAPPINESS,
> +               .procname       = "autoswappiness",
> +               .data           = &auto_swappiness,
> +               .maxlen         = sizeof(auto_swappiness),
> +               .mode           = 0644,
> +               .proc_handler   = &proc_dointvec_minmax,
> +               .strategy       = &sysctl_intvec,
> +               .extra1         = &zero,
> +               .extra2         = &one_hundred,
> +       },
> shouldn't be proc_dointvec here? seems minmax isn't needed.

Err yeah sure, thanks.

Con

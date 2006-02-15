Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423055AbWBOJDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423055AbWBOJDd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 04:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423056AbWBOJDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 04:03:33 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:8305 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423055AbWBOJDb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 04:03:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U3poV/2jZqBZysFYBxHYmvhwlVekadl3MBUp2MZOhvEIgdq1BzwsPqAdcDbyDc/TGtYIbtcZTuNF7xmpItBHCQ/djpB4TbZEvqe4nVXjorsOHACQBYKapqdoCmIMW8df5u4/lu8FDMcXHtg6tEms7sT42u0E2j4MCQR9R2WuoeI=
Message-ID: <ff1cadb20602150103u437562ddu@mail.gmail.com>
Date: Wed, 15 Feb 2006 10:03:30 +0100
From: Luca Falavigna <dktrkranz@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] CONSOLE_LP_STRICT Kconfig option
Cc: linux-kernel@vger.kernel.org, rdunlap@xenotime.net
In-Reply-To: <p731wy63s0j.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43F1ED62.4050609@gmail.com> <p731wy63s0j.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, I noticed I sent twice my email. Sorry.

14 Feb 2006 15:59:56 +0100, Andi Kleen <ak@suse.de>:
> This shouldn't be a CONFIG. This should be a runtime option.
> It's ridiculous to have to recompile your kernel just to fix some
> problem with your printer.
>
> e.g. sysctl, ioctl, sysfs entry, module parameter. Whatever is en
> vogue these days. Easiest would be probably a module_param().

This feature only gets involved when passing console=lp0 parameter to
the bootloader. I never tried to load a new system console while
system was running so I'm not sure if it behaves correctly. If it
does, I will modify this patch following your advices.

Regards,

--
Luca

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262656AbUKELyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbUKELyr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 06:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbUKELyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 06:54:47 -0500
Received: from cantor.suse.de ([195.135.220.2]:676 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262656AbUKELyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 06:54:33 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm3
References: <20041105001328.3ba97e08.akpm@osdl.org.suse.lists.linux.kernel>
	<418B5C70.7090206@kolivas.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Nov 2004 12:53:36 +0100
In-Reply-To: <418B5C70.7090206@kolivas.org.suse.lists.linux.kernel>
Message-ID: <p73sm7o7br3.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> It's life Jim but not as we know it...
> 
> 
> This happened during modprobe of alsa modules. Keyboard still alive,
> everything else dead; not even sysrq would do anything, netconsole had
> no output, luckily this made it to syslog:

I just tested modprobing of alsa (snd_intel8x0) and it works for me.
Also vmalloc must work at least to some point.

Can you confirm it's really caused by 4level by reverting all the 
4level-* patches from broken out? 

-Andi

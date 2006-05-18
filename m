Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWERI3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWERI3f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 04:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWERI3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 04:29:34 -0400
Received: from mail.suse.de ([195.135.220.2]:26768 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750974AbWERI3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 04:29:34 -0400
Message-ID: <446C3064.3030409@suse.de>
Date: Thu, 18 May 2006 10:29:24 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060411)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range
 patch
References: <1147759423.5492.102.camel@localhost.localdomain> <20060516064723.GA14121@elte.hu> <1147852189.1749.28.camel@localhost.localdomain> <20060518075437.GA29747@elte.hu>
In-Reply-To: <20060518075437.GA29747@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> (and it would be nice to do this on x86_64 too - exploits already exist 
> using the fixmapped VDSO there as a trampoline.)

At least for the ia32 emulation that should be easy as the idea to
implement the vsyscall page as vma was shamlessly stolen from andy's
arch/x86_64/ia32/syscall32.c ;)

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
Erst mal heiraten, ein, zwei Kinder, und wenn alles läuft
geh' ich nach drei Jahren mit der Familie an die Börse.
http://www.suse.de/~kraxel/julika-dora.jpeg

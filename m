Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263104AbUEBPfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbUEBPfn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 11:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUEBPfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 11:35:43 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:14538 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S263104AbUEBPfl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 11:35:41 -0400
In-Reply-To: <200405021305.i42D5L625036@tag.witbe.net>
References: <200405021305.i42D5L625036@tag.witbe.net>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5C616C5C-9C4E-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: <mbligh@aracnet.com>, <rusty@rustcorp.com.au>,
       "'Sean Estabrooks'" <seanlkml@rogers.com>, <riel@redhat.com>,
       <nico@cam.org>, <tconnors+linuxkernel1083378452@astro.swin.edu.au>,
       <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] clarify message and give support contact for non-GPL modules
Date: Sun, 2 May 2004 11:35:37 -0400
To: <rol@as2917.net>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 2, 2004, at 9:05 AM, Paul Rolland wrote:
>
> Agreed. Once you have loaded such a module, your kernel is really
> "tainted" by something that cannot really be controlled.
> Proprietary is too much neutral and doesn't reflect what you are
> now running : some piece of code which may by bloated without anyone
> being able to control it.

There will always be things in life that cannot be controlled. The 
kernel already depends on (by being called by, or itself calling) 
uncontrolled proprietary code in many environments without telling 
users about it. Informing people about this is perfectly ok,  
unnecessarily scaring or confusing them is not.

> I simply hope that some "vendors" will not alter kernel code before
> building to remove such a warning if they include closed source
> module in their distro.

Very good point. You can make things as negative-sounding, politically 
hostile as you want, but Linux distribution vendors would be perfectly 
free under the GPL to modify the kernel to remove or attenuate 
exaggerated messages and any other hostile measures if necessary.

If the messages are reasonable and clear, no-one will want/try to 
remove or avoid them, and people will be properly informed.

Marc


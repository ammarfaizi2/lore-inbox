Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTEQLJb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 07:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTEQLJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 07:09:31 -0400
Received: from pop.gmx.de ([213.165.65.60]:32938 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261411AbTEQLJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 07:09:30 -0400
Message-ID: <3EC61B63.9020906@gmx.net>
Date: Sat, 17 May 2003 13:22:11 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: Andrew Morton <akpm@digeo.com>, rmk@arm.linux.org.uk,
       LKML <linux-kernel@vger.kernel.org>, davej@suse.de
Subject: Re: 2.5.69-mm6: pccard oops while booting: round 2
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com>	 <20030514191735.6fe0998c.akpm@digeo.com>	 <1052998601.726.1.camel@teapot.felipe-alfaro.com>	 <20030515130019.B30619@flint.arm.linux.org.uk>	 <1053004615.586.2.camel@teapot.felipe-alfaro.com>	 <20030515144439.A31491@flint.arm.linux.org.uk>	 <1053037915.569.2.camel@teapot.felipe-alfaro.com>	 <20030515160015.5dfea63f.akpm@digeo.com>	 <1053090184.653.0.camel@teapot.felipe-alfaro.com>	 <1053110098.648.1.camel@teapot.felipe-alfaro.com>	 <20030516132908.62e54266.akpm@digeo.com>	 <1053121346.569.1.camel@teapot.felipe-alfaro.com>	 <3EC56173.1000306@gmx.net>	 <1053166275.586.9.camel@teapot.felipe-alfaro.com>	 <20030517031840.486683fc.akpm@digeo.com> <1053169552.613.1.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1053169552.613.1.camel@teapot.felipe-alfaro.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:
> On Sat, 2003-05-17 at 12:18, Andrew Morton wrote:
> 
>>Bummer.  Vital info is chopped off the top of the oops output.
> 
> I've been working on this a little this morning and these are the new
> conclusions I've drawn:
> 
> 1. Definitively, the oops is being caused by the YMFPCI driver. I have
> built a mini-kernel by squashing the config to a minimum (disabled
> modules, preemptive, removed USB, IDE, AGP, Networking, CardBus, and

Could you please enable modules again and load ymfpci as module? This is
supposed to give the best results with ymfpci2.patch. For ymfpci built
in, the patch unfortunately does not help much.

> nearly everything possible) and the kernel still faults.

Thanks for your patience,
Carl-Daniel


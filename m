Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313279AbSDDRl1>; Thu, 4 Apr 2002 12:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313276AbSDDRlI>; Thu, 4 Apr 2002 12:41:08 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:31943 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S313271AbSDDRlF>;
	Thu, 4 Apr 2002 12:41:05 -0500
Date: Thu, 4 Apr 2002 09:40:57 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: flaniganr@intel.co.jp, linux-kernel@vger.kernel.org,
        dhinds@zen.stanford.edu, Robert Love <rml@tech9.net>
Subject: Re: [PATCH] 2.5.8-pre1 wavelan_cs
Message-ID: <20020404094057.B26632@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <87vgb8x8bt.fsf@hazuki.jp.intel.com> <3CABFE55.9@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 02:18:45AM -0500, Jeff Garzik wrote:
> flaniganr@intel.co.jp wrote:
> > not sure if i did this right, so if you 
> > have any suggestions/comments please tell me.
> > 
> > Basically 2.5.8-pre1 fails to compile with:
> > 
> > In file included from wavelan_cs.c:59:
> > wavelan_cs.p.h:495:33: warning: extra tokens at end of #undef directive
> > wavelan_cs.c: In function `wv_pcmcia_config':
> > wavelan_cs.c:4480: structure has no member named `rmem_start'
> > wavelan_cs.c:4482: structure has no member named `rmem_end'
> > make[3]: *** [wavelan_cs.o] Error 1
> 
> not needed, just delete the unused references to rmem_{start,end}.
> (see attached patch)
> 
> 	Jeff

	Correct. It was just information displayed by ifconfig.
	Jeff, will you take care of it or do you need an "official"
patch (I would just resend your patch + the one of Robert).
	Thanks...

	Jean

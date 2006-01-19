Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422669AbWASWSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422669AbWASWSR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422670AbWASWSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:18:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37895 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422669AbWASWSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:18:15 -0500
Date: Thu, 19 Jan 2006 23:18:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>, Krzysztof Halasa <khc@pm.waw.pl>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       perex@suse.cz
Subject: Re: [Alsa-devel] Re: RFC: OSS driver removal, a slightly different approach
Message-ID: <20060119221813.GB19398@stusta.de>
References: <20060119174600.GT19398@stusta.de> <m3ek34vucz.fsf@defiant.localdomain> <1137703413.32195.23.camel@mindpipe> <20060119215008.GB6595@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119215008.GB6595@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 04:50:08PM -0500, Bill Nottingham wrote:
> Lee Revell (rlrevell@joe-job.com) said: 
> > Yes, it would require a collector of ancient sound hardware... do you
> > know anyone like that?
> 
> If someone desparately wants a AdLib or PAS16 I might be able to
> scrounge one up. However, are there really users out there
> insisting that their Linux experience is suffering because they
> don't have support for their 8-bit ISA FM synth card?

Half of the cards without ALSA drivers are ancient PC hardware and the 
other half are drivers for !i386 platforms.

Me scheduling other OSS drivers for removal brought me indirectly in
contact with two users of SOUND_TRIX and one user of SOUND_VIDC - and 
I'd assume that most of such hardware has some users somewhere.

I don't consider it a big problem if a handful OSS drivers for obscure 
hardware will stay forever (although getting ALSA drivers for all 
hardware would be the superior solution).

We are already able to both remove a serious amount of code and getting 
many bug reports against the ALSA drivers without removing support for a 
single piece of hardware.

> Bill

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


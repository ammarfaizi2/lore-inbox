Return-Path: <linux-kernel-owner+w=401wt.eu-S933194AbWLaQ23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933194AbWLaQ23 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 11:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933195AbWLaQ23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 11:28:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2497 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933194AbWLaQ22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 11:28:28 -0500
Date: Sun, 31 Dec 2006 17:28:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.6.19.1
Message-ID: <20061231162830.GL20714@stusta.de>
References: <200612301224_MC3-1-D6C5-9FCD@compuserve.com> <200612301829.15980.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612301829.15980.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2006 at 06:29:15PM +0000, Alistair John Strachan wrote:
> On Saturday 30 December 2006 17:21, Chuck Ebbert wrote:
> > In-Reply-To: <200612301659.35982.s0348365@sms.ed.ac.uk>
> >
> > On Sat, 30 Dec 2006 16:59:35 +0000, Alistair John Strachan wrote:
> > > I've eliminated 2.6.19.1 as the culprit, and also tried toggling
> > > "optimize for size", various debug options. 2.6.19 compiled with GCC
> > > 4.1.1 on an Via Nehemiah C3-2 seems to crash in pipe_poll reliably,
> > > within approximately 12 hours.
> >
> > Which CPU are you compiling for?  You should try different options.
> 
> I should, I haven't thought of that. Currently it's compiling for 
> CONFIG_MVIAC3_2, but I could try i686 for example.
> 
> > Can you post disassembly of pipe_poll() for both the one that crashes
> > and the one that doesn't?  Use 'objdump -D -r fs/pipe.o' so we get the
> > relocation info and post just the one function from each for now.
> 
> Sure, no problem:
> 
> http://devzero.co.uk/~alistair/2.6.19-via-c3-pipe_poll/
> 
> Both use identical configs, neither are optimised for size. The config is 
> available from the same location.

Can you try enabling as many debug options as possible?

> Cheers,
> Alistair.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


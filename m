Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263991AbSKMVId>; Wed, 13 Nov 2002 16:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbSKMVIc>; Wed, 13 Nov 2002 16:08:32 -0500
Received: from hermes.domdv.de ([193.102.202.1]:58890 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S263991AbSKMVHx>;
	Wed, 13 Nov 2002 16:07:53 -0500
Message-ID: <3DD2C0BE.80002@domdv.de>
Date: Wed, 13 Nov 2002 22:14:38 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: make distclean and make dep??
References: <Pine.LNX.4.44.0211131417480.32544-100000@oddball.prodigy.com> <20021113205844.GB2822@mars.ravnborg.org>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Wed, Nov 13, 2002 at 02:32:27PM -0500, Bill Davidsen wrote:
>>Also noted, somewhere between 2.5.45 and 2.5.46 distclean vanished from 
>>"make help." It's really useful to have distclean work to build patched 
>>kernels for distribution, hopefully this is an oversight and not a new 
>>policy.
> 
> Since they are equal I removed the help for the less used version.

Not so nice. /me e.g. is used to distclean, never used mrproper and 
distclean is a standard target in most projects, so people are probably 
more used to distclean than mrproper which is kernel specific.
The thing to point this out is that if the help is removed the target 
will presumably be removed sooner or later, too.


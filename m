Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264086AbRFFTCE>; Wed, 6 Jun 2001 15:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264093AbRFFTBy>; Wed, 6 Jun 2001 15:01:54 -0400
Received: from blackhole.compendium-tech.com ([64.156.208.74]:29332 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S264086AbRFFTBf>; Wed, 6 Jun 2001 15:01:35 -0400
Date: Wed, 6 Jun 2001 12:01:25 -0700 (PDT)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
X-X-Sender: <kernel@sol.compendium-tech.com>
To: "David N. Welton" <davidw@apache.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: temperature standard - global config option?
In-Reply-To: <87snhdvln9.fsf@apache.org>
Message-ID: <Pine.LNX.4.33.0106061158020.28908-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Jun 2001, David N. Welton wrote:

>
> [ please CC replies to me ]
>
> Perusing the kernel sources while investigating watchdog drivers, I
> notice that in some places, Fahrenheit is used, and in some places,
> Celsius.  It would seem logical to me to have a global config option,
> so that you *know* that you talk devices either in F or C.
>
> I searched the archives for discussions regarding this, but didn't
> find anything, apologies if I missed something.

If something is done, Celsius should be default (as the US is brain-dead
like that; nearly everywhere else uses Celsius as the standard) and
fahrenheit as an option.

I wrote a patch for the 'sensors' utility in lm_sensors that did just
that; supplied fahrenheit conversion for the sensors via a commandline
option. Perhaps there could be a config option in the kernel (or a proc
entry/ioctl?) that controls this.


 Kelsey Hudson                                           khudson@ctica.com
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------


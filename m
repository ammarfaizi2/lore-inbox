Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288287AbSACTjt>; Thu, 3 Jan 2002 14:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288288AbSACTjk>; Thu, 3 Jan 2002 14:39:40 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:26245 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S288287AbSACTj3>; Thu, 3 Jan 2002 14:39:29 -0500
Message-ID: <3C34B35A.7000309@allegientsystems.com>
Date: Thu, 03 Jan 2002 14:39:06 -0500
From: Nathan Bryant <nbryant@allegientsystems.com>
Organization: Allegient Systems
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Thomas Gschwind <tom@infosys.tuwien.ac.at>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: i810_audio]
In-Reply-To: <3C3382CA.3000503@allegientsystems.com> <3C345493.5040800@evision-ventures.com> <20020103154718.C32419@infosys.tuwien.ac.at> <3C347A12.3070404@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:

[snip]

> example. The artsd from KDE as usuall is failing blatantly and locks 
> the system hard...
> And I don't have neither the time, nor inclination for debuggin it...
> (Unless I could compile the whole KDE proerply with some recent 
> gcc-3.x for RedHat ;-). 

There were numerous problems in the 0.04 i810_audio driver that caused 
problems with artsd. It sounds as if Tom has at least partial fixes for 
most of these in his patch, but he doesn't mention the poll() problem 
that we encountered...

artsd should work with 0.13 if we can get the SiS changes merged in. The 
artsd problems weren't specific to the type of hardware changes Tom is 
reporting... more like generic problems with the driver's 
userland-interface semantics and DMA state tracking.

> Recodring did lockup the system hard as well immediately, no matter what. 

Recording is something I never really tested heavily, though it does 
seem to work at least minimally on my system (driver-default rates, 
etc.) I'd be interested in any feedback as to whether it works in 0.13, 
both from SiS users and otherwise...

Other people have said that RealProducer works fine, though, with newer 
versions of Doug's driver, at all rates, etc.


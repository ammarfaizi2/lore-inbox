Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262705AbRE3Mwp>; Wed, 30 May 2001 08:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262773AbRE3Mwf>; Wed, 30 May 2001 08:52:35 -0400
Received: from pD9004ADD.dip.t-dialin.net ([217.0.74.221]:58338 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S262705AbRE3Mwb>;
	Wed, 30 May 2001 08:52:31 -0400
Message-ID: <3B14ECF7.937C2A8@pcsystems.de>
Date: Wed, 30 May 2001 14:52:07 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ PATCH ]: disable pcspeaker kernel: 2.4.2 - 2.4.5
In-Reply-To: <Pine.LNX.4.33.0105301414080.6313-200000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


Where did you put the config.in entries to ?
This way it would be enabled all the time... okay...
I like that, too.
In the version I set up, I used the config.in entries,
because if you use disable pc_speaker, there is at
least one more int in the kernel. This is surely now much,
but as it is not needed all the time, I thought about choosing it
from menuconfig/config/...

So in short:

less code / one int more in the kernel
or
more code and #ifs / one int less in the kernel

What do you think is better ? I agree that the above one
is nicer code, but in fact I would prefer the second solution.

And what about the code from kernel/sys.c ?
The version you provided doesn't take care of what's
the default value of pcspeaker. This would make it
undefined, which is not really good.

Regards,

Nico

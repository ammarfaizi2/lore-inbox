Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275353AbRIZRYC>; Wed, 26 Sep 2001 13:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275355AbRIZRXw>; Wed, 26 Sep 2001 13:23:52 -0400
Received: from zeke.inet.com ([199.171.211.198]:58543 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S275353AbRIZRXh>;
	Wed, 26 Sep 2001 13:23:37 -0400
Message-ID: <3BB20F26.5575897B@inet.com>
Date: Wed, 26 Sep 2001 12:23:50 -0500
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.19-6.2.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Padraig Brady <padraig@antefacto.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] core file naming option
In-Reply-To: <E15mHSd-0000mh-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Other Unix' have used core.pid as the name. Wouldn't this be better?
> > Especially when the process name is already stored in a core file
> > (`file core` will give you this). Hmm I wonder could we use this
> > core.pid format to dump the core for each thread (probably a bad idea).
> 
> The -ac tree and latest -linus can use core.pid for each thread already

Ah, I see: /proc/sys/kernel/core_uses_pid if I'm not mistaken.

However, my primary interest is with the 2.2.x series, and I don't see
this in 2.2.19.
Is this something that will be moving to 2.2.19?  Are there
philisophical or technical reasons one way or the other?

Thank you for your time,

Eli
--------------------.     Real Users find the one combination of bizarre
Eli Carter           \ input values that shuts down the system for days.
eli.carter(a)inet.com `-------------------------------------------------

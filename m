Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261513AbTCZJJQ>; Wed, 26 Mar 2003 04:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261514AbTCZJJQ>; Wed, 26 Mar 2003 04:09:16 -0500
Received: from buitenpost.surfnet.nl ([192.87.108.12]:45496 "EHLO
	buitenpost.surfnet.nl") by vger.kernel.org with ESMTP
	id <S261513AbTCZJJO>; Wed, 26 Mar 2003 04:09:14 -0500
Date: Wed, 26 Mar 2003 10:20:19 +0100
To: Arne Koewing <ark@gmx.net>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [patch] Synaptics touchpad with Trackpoint needs ps/2 reset
Message-ID: <20030326092018.GA6733@pangsit>
References: <87r88uv7hf.fsf@localhost.i-did-not-set--mail-host-address--so-tickle-me>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r88uv7hf.fsf@localhost.i-did-not-set--mail-host-address--so-tickle-me>
X-Mailer: Mutt on Debian GNU/Linux sid
X-Editor: vim
X-Organisation: SURFnet bv
X-Address: Radboudburcht, P.O. Box 19035, 3501 DA Utrecht, NL
X-Phone: +31 302 305 305
X-Telefax: +31 302 305 329
User-Agent: Mutt/1.5.4i
From: Niels den Otter <otter@surfnet.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arne,

On Tuesday, 25 March 2003, Arne Koewing wrote:
> I recently posted this to linux-kernel (with a different subject) I
> had included a wrong ptch there, i think this one is ok.
> 
> As some people before I had the 'Dell trackpoint does not work'
> problem after upgrading to 2.5.XX:
> That was:
>      
> the trackpoint of your dell won't work until:
>     - hibernate and wake up the system again
>     - plug in an external mouse (you may remove it immediately)
> 
> it seems that dells hardware is disabling the trackpoint if you probed
> for the touchpad.  A device reset after probing does help, but I've no
> idea how this would affect other synaptics touchpad devices although I
> think most devices will not complain about one extra reset.

Thanks for making this patch available! It works really great for me on
my Dell Latitude C400. After a fresh boot of the Linux kernel both the
trackpoint and the touchpad now both work.


Thanks,

Niels

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264215AbUDHJFg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 05:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264219AbUDHJFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 05:05:34 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:18838 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264215AbUDHJFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 05:05:30 -0400
Message-ID: <407515B0.6070803@myrealbox.com>
Date: Thu, 08 Apr 2004 02:04:48 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jason Harrison <jharrison@linuxbs.dyndns.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5 blank console display
References: <fa.jla2q0h.1ok41rf@ifi.uio.no>
In-Reply-To: <fa.jla2q0h.1ok41rf@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I might have the same problem.  I switched from 2.6.5-rc1 (I think) to 2.6.5 and 
lost my console.  Unfortunately I don't have the old config handy, but I'm 
pretty sure I had the framebuffer console off.  The only was I got my console 
back was to enable fbcon.  This is on x86_64 with a generic 32MB SiS card.

Any useful information I could send?

--Andy

Jason Harrison wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Greetings,
> 
> I have upgraded to 2.6.5 from 2.6.4 after which I have no console display.  I 
> have used my 2.6.4 .config (which worked fine) to configure 2.6.5.  I have 
> all the usual settings compiled into the kernel for virtual terminals and 
> such to work.  Is there any options at all that I might somehow be missing?  
> Are there any new options I need that were introduced in 2.6.5?  I really 
> want to get this sorted out.
> 
> Thank you all for your time and help.
> 
> Regards,
> Jason Harrison
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> 
> iD8DBQFAc2Q/pEWPjYSBsRERAs7lAKDHBNo+q6qZlLDRaU1D0W3DWQeNMQCgjlNq
> rvwym7zPln6EOGkOIWX1x5k=
> =NZbP
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

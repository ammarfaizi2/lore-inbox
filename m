Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUC2W1j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 17:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbUC2W1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 17:27:39 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:54281 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S263159AbUC2W1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 17:27:36 -0500
Date: Tue, 30 Mar 2004 00:27:10 +0200
From: DervishD <raul@pleyades.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Lev Lvovsky <lists1@sonous.com>, linux-kernel@vger.kernel.org
Subject: Re: older kernels + new glibc?
Message-ID: <20040329222710.GA8204@DervishD>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Lev Lvovsky <lists1@sonous.com>, linux-kernel@vger.kernel.org
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com> <Pine.LNX.4.53.0403291602340.2893@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0403291602340.2893@chaos>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Richard :)

 * Richard B. Johnson <root@chaos.analogic.com> dixit:
> For glibc compatibility you need to get rid of the sym-link(s)
> /usr/include/asm and /usr/include/linux in older distributions.
> You need to replace those with headers copied from the kernel
> in use when the C runtime library was compiled. If you can't find
> those, you can either upgrade your C runtime library, or copy
> headers from some older kernel that was known to work.
> In any event, you need to remove the sym-link that ends up
> pointing to your 'latest and greatest' kernel.

    Mmm, I'm confused. As far as I knew, you *should* use symlinks to
your current (running) kernel includes for /usr/include/asm and
/usr/include/linux. I've been doing this for years (in fact I
compiled my libc back in the 2.2 days IIRC), without problems. Why it
should be avoided and what kind of problems may arise if someone
(like me) has those symlinks?

    User space programs should not use kernel headers, so this
shouldn't be a problem, and kernel related tools should use the
headers from the current (running) kernel or a similar version (here
'similar' as a broad meaning, I think, let's say that it means 'same
series as the running kernel, but newer), but I'm afraid I'm missing
something...

    Thanks in advance :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/

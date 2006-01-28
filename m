Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422785AbWA1Bqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422785AbWA1Bqn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 20:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422786AbWA1Bqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 20:46:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41891 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422785AbWA1Bqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 20:46:42 -0500
Date: Fri, 27 Jan 2006 20:46:08 -0500 (EST)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Simon Oosthoek <simon.oosthoek@ti-wmc.nl>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <20060127133939.GU27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0601272043020.3192@evo.osdl.org>
References: <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com>
 <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com>
 <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>
 <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com>
 <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse>
 <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <43D9F9F9.5060501@ti-wmc.nl>
 <20060127133939.GU27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Jan 2006, Al Viro wrote:
> 
> Bzzert.   "GPLv2 only in the context of the Linux kernel" is incompatible
> with GPLv2 and means that resulting kernel is impossible to distribute.

Indeed. The GPL (both v2 and v3) disallow restricting usage. 

So certain _code_ can be either v2 or v3 only, but you can't make that 
decision based on how the code is used. 

So you can't license, for example, your code "udner the GPL only for the 
Linux kernel". Trust me, some companies have actually wanted to do exactly 
that - they wanted to distribute their code, but _only_ for the kernel 
(and you'd not be allowed to use it for any other GPL'd project). That 
just cannot fly. It's either GPL, or it isn't. There's no "GPL with the 
following rules".

		Linus

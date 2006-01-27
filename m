Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWA0Kq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWA0Kq2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 05:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWA0Kq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 05:46:28 -0500
Received: from darla.ti-wmc.nl ([217.114.97.45]:39301 "EHLO smtp.wmc")
	by vger.kernel.org with ESMTP id S1751256AbWA0Kq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 05:46:27 -0500
Message-ID: <43D9F9F9.5060501@ti-wmc.nl>
Date: Fri, 27 Jan 2006 11:46:17 +0100
From: Simon Oosthoek <simon.oosthoek@ti-wmc.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <43D114A8.4030900@wolfmountaingroup.com> <20060120111103.2ee5b531@dxpl.pdx.osdl.net> <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com> <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com> <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> The Linux kernel is under the GPL version 2. Not anything else. Some
>  individual files are licenceable under v3, but not the kernel in
> general.

I believe that if v2 and v3 turn out to be incompatible, it would be
quite hard to rationalise v3+ licensed files inside the kernel. So when
people want their code to be in the kernel and still be v3+ compatible,
they should probably dual license it, or include a specific section
saying that the code can be licensed under v2 only if in the context of
the Linux kernel.

> And quite frankly, I don't see that changing. I think it's insane to
>  require people to make their private signing keys available, for
> example. I wouldn't do it. So I don't think the GPL v3 conversion is
> going to happen for the kernel, since I personally don't want to
> convert any of my code.

I'm not sure this is the correct interpretation of the current draft. I
assume you're referring to this part:

GPLv3-draft1:
 > (...)
> Complete Corresponding Source Code also includes any encryption or
> authorization codes necessary to install and/or execute the source
> code of the work, perhaps modified by you, in the recommended or
> principal context of use, such that its functioning in all
> circumstances is identical to that of the work, except as altered by
> your modifications. It also includes any decryption codes necessary
> to access or unseal the work's output. Notwithstanding this, a code
> need not be included in cases where use of the work normally implies
> the user already has it.
> (...)

I'd interpret that as forcing people who try to hide their code or make 
it difficult to get at the source code to not be able to do that. I'm 
not sure this would affect the Linux kernel at all and I don't think it 
would require any of your private keys to be disclosed at all. If you 
would sign or encrypt the kernel distribution with your private key, 
everyone would need to have access to your public key, but that's the 
whole idea anyway.

Cheers

Simon

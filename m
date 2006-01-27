Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWA0OA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWA0OA7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 09:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWA0OA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 09:00:59 -0500
Received: from darla.ti-wmc.nl ([217.114.97.45]:30604 "EHLO smtp.wmc")
	by vger.kernel.org with ESMTP id S1750981AbWA0OA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 09:00:59 -0500
Message-ID: <43DA2795.707@ti-wmc.nl>
Date: Fri, 27 Jan 2006 15:00:53 +0100
From: Simon Oosthoek <simon.oosthoek@ti-wmc.nl>
Organization: WMC
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com> <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com> <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <43D9F9F9.5060501@ti-wmc.nl> <20060127133939.GU27946@ftp.linux.org.uk>
In-Reply-To: <20060127133939.GU27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Fri, Jan 27, 2006 at 11:46:17AM +0100, Simon Oosthoek wrote:
>> Linus Torvalds wrote:
>>> The Linux kernel is under the GPL version 2. Not anything else. Some
>>> individual files are licenceable under v3, but not the kernel in
>>> general.
>> I believe that if v2 and v3 turn out to be incompatible, it would be
>> quite hard to rationalise v3+ licensed files inside the kernel. So when
>> people want their code to be in the kernel and still be v3+ compatible,
>> they should probably dual license it, or include a specific section
>> saying that the code can be licensed under v2 only if in the context of
>> the Linux kernel.
> 
> Bzzert.   "GPLv2 only in the context of the Linux kernel" is incompatible
> with GPLv2 and means that resulting kernel is impossible to distribute.

really? if it was dual licensed (that's what I meant, perhaps the "or" 
should be an "and"? ;-), v2 in the kernel and v3(or any later version, 
etc.), if the code is used outside of the kernel, it would "fall back 
to" v3+ as soon as it's taken out of the kernel and used in something else.

If I'd want to contribute code to the kernel, I'd have to comply with 
the license of the kernel, which is v2 of the GPL. If I would actually 
prefer my code to be licensed under v3 or higher, I'd have to specify 
that my code is only licensed under v2 for the kernel to humour Linus 
Torvalds and respect the license of the kernel, but in all other ways 
the code is used, I only grant a license to copy under the conditions of 
the GPL v3 or higher. I don't see why that would affect the distribution 
of the kernel at all.

Cheers

Simon


-- 
phone:(+31|0)53 4810319
fax:  (+31|0)53 4810333
simon.oosthoek@ti-wmc.nl
http://www.ti-wmc.nl/

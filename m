Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWA0Oql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWA0Oql (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 09:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWA0Oql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 09:46:41 -0500
Received: from [204.225.94.109] ([204.225.94.109]:7691 "EHLO pcburn.com")
	by vger.kernel.org with ESMTP id S1751466AbWA0Oqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 09:46:40 -0500
Message-ID: <43DA3248.1090202@pcburn.com>
Date: Fri, 27 Jan 2006 09:46:32 -0500
From: Chris Bergeron <chris@pcburn.com>
Reply-To: chris@pcburn.com
Organization: PCBurn Media
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com> <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com> <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <43D9F9F9.5060501@ti-wmc.nl> <20060127133939.GU27946@ftp.linux.org.uk> <43DA2795.707@ti-wmc.nl>
In-Reply-To: <43DA2795.707@ti-wmc.nl>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Oosthoek wrote:
> Al Viro wrote:
>> On Fri, Jan 27, 2006 at 11:46:17AM +0100, Simon Oosthoek wrote:
>>> Linus Torvalds wrote:
>>>> The Linux kernel is under the GPL version 2. Not anything else. Some
>>>> individual files are licenceable under v3, but not the kernel in
>>>> general.
>>> I believe that if v2 and v3 turn out to be incompatible, it would be
>>> quite hard to rationalise v3+ licensed files inside the kernel. So when
>>> people want their code to be in the kernel and still be v3+ compatible,
>>> they should probably dual license it, or include a specific section
>>> saying that the code can be licensed under v2 only if in the context of
>>> the Linux kernel.
>>
>> Bzzert.   "GPLv2 only in the context of the Linux kernel" is 
>> incompatible
>> with GPLv2 and means that resulting kernel is impossible to distribute.
> If I would actually prefer my code to be licensed under v3 or higher, 
> I'd have to specify that my code is only licensed under v2 for the 
> kernel to humour Linus Torvalds and respect the license of the kernel, 
> but in all other ways the code is used, I

I think what the "Bzzert" is implying is that once you license your code 
under the GPL v2 for the kernel use, it's then licensed that way for 
distribution.  You can't prohibit people from using it in other contexts 
with that license or it violates the GPL v2 license and then can't be 
distributed with the kernel, either. If I'm reading that correctly.

To cross license you'd have to allow either license for any use, really, 
as long as the use complies with the license.  Adding 'if the code is 
used outside of the kernel, it would "fall back to" v3+' would violate 
the GPL v2.

-- Chris

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVGZPKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVGZPKa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 11:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVGZPII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:08:08 -0400
Received: from relay00.pair.com ([209.68.1.20]:25103 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S261851AbVGZPGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:06:20 -0400
X-pair-Authenticated: 209.68.2.107
Message-ID: <42E65167.7050509@cybsft.com>
Date: Tue, 26 Jul 2005 10:06:15 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: john cooper <john.cooper@timesys.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 PREEMPT_RT && PPC
References: <200507200816.11386.kernel@kolivas.org> <20050719223216.GA4194@elte.hu> <1121819037.26927.75.camel@dhcp153.mvista.com> <200507201104.48249.kernel@kolivas.org> <1121822524.26927.85.camel@dhcp153.mvista.com> <42DF293A.4050702@timesys.com> <20050726120015.GB9224@elte.hu> <42E64C43.2050104@cybsft.com> <20050726145500.GA18752@elte.hu>
In-Reply-To: <20050726145500.GA18752@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>><snip>
>>
>>On X86 -51-36 won't build with CONFIG_BLOCKER=Y without the attached 
>>patch.
> 
> 
> thanks. I changed the include to asm/rtc.h, this should give what PPC 
> wants to have, and should work on all architectures. Released the -37 
> patch.
> 
> 	Ingo
> 

Sorry I overlooked the get_tbu and get_tbl calls. Thought the include 
was a leftover or something. :-/

-- 
    kr

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290557AbSARAaC>; Thu, 17 Jan 2002 19:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290559AbSARA3y>; Thu, 17 Jan 2002 19:29:54 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:17629 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S290557AbSARA3n>;
	Thu, 17 Jan 2002 19:29:43 -0500
Message-ID: <3C476C53.6060400@candelatech.com>
Date: Thu, 17 Jan 2002 17:29:07 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Jes Sorensen <jes@wildopensource.com>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] VAIO irq assignment fix
In-Reply-To: <Pine.LNX.4.33.0201171804510.23659-100000@Appserv.suse.de> <Pine.LNX.4.33.0201171433260.3114-100000@penguin.transmeta.com> <20020118001244.B28183@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dave Jones wrote:

> On Thu, Jan 17, 2002 at 02:35:30PM -0800, Linus Torvalds wrote:
>  > No. Could we please integrate this not with ACPI, but with the much more
>  > limited "arch/i386/kernel/acpitable.c", which does NOT imply full ACPI,
>  > only scanning the tables for information in static format (like the irq
>  > routing stuff).
> 
>  I was under the impression that the Intel ACPI folks had things in
>  mind for acpitable.c along the lines of 'rm', in favour of having 
>  their new interpretor do a "Load, setup, get the hell out" approach
>  for those that didn't want it staying around.
> 
>  Either way, I agree improving our ACPI support is a better solution
>  in the long run.


No argument here, but I'd love to use my cardbus NICs in my VAIO
one way or another in the next stable kernel!


> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267528AbTBDWtq>; Tue, 4 Feb 2003 17:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267530AbTBDWtq>; Tue, 4 Feb 2003 17:49:46 -0500
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:52102
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S267528AbTBDWtp>; Tue, 4 Feb 2003 17:49:45 -0500
Message-ID: <3E4045D1.4010704@rogers.com>
Date: Tue, 04 Feb 2003 17:59:29 -0500
From: Jeff Muizelaar <muizelaar@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
References: <1044385759.1861.46.camel@localhost.localdomain.suse.lists.linux.kernel> <200302041935.h14JZ69G002675@darkstar.example.net.suse.lists.linux.kernel> <b1pbt8$2ll$1@penguin.transmeta.com.suse.lists.linux.kernel> <p73znpbpuq3.fsf@oldwotan.suse.de>
In-Reply-To: <p73znpbpuq3.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep04-mail.bloor.is.net.cable.rogers.com from [24.43.126.4] using ID <muizelaar@rogers.com> at Tue, 4 Feb 2003 17:59:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>If you want small and fast use lcc.
>
>Unfortunately it's not completely free (some weird license), doesn't
>really support real inline assembly and generates rather bad code compared 
>to gcc.
>
>I'm still looking forward to Open Watcom (http://www.openwatcom.org) - 
>they are near self hosting on Linux. The inline assembly is very VC++ style 
>though; very different from gcc and worse you have to write it in
>Intel syntax.
>
>Another alternative would be TenDRA, but it also has no inline assembly
>and it's C understanding can be only described as "fascist".
>
>If you don't care about free software you could also use the Intel
>compiler, which seems to be often faster in compile time than gcc now
>and can already compile kernels.
>
There is also tcc (http://fabrice.bellard.free.fr/tcc/)
It claims to support gcc-like inline assembler, appears to be much 
smaller and faster than gcc. Plus it is GPL so the liscense isn't a 
problem either.
Though, I am not really sure of the quality of code generated or of how 
mature it is.

-Jeff



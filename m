Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266263AbRGGOGV>; Sat, 7 Jul 2001 10:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266269AbRGGOGL>; Sat, 7 Jul 2001 10:06:11 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:26824 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266263AbRGGOF7>;
	Sat, 7 Jul 2001 10:05:59 -0400
Message-ID: <3B471742.A8F1A25F@mandrakesoft.com>
Date: Sat, 07 Jul 2001 10:05:54 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <3B47116C.14118B9C@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Oh this is a fun one :)
> 
> When building gcc-2.96 RPM using gcc-2.96 under kernel 2.4.7 on alpha,
> the system goes --deeply-- into swap.  Not pretty at all.  The system
> will be 200MB+ into swap, with 200MB+ in cache!  I presume this affects
> 2.4.7-release also.
> 
> System has 256MB of swap, and 384MB of RAM.
> 
> Only patches applied are Rik's recent OOM killer friendliness patch, and
> Andrea's ksoftirq patch.
> 
> I ran "vmstat 3" throughout the build, and that output is attached.  I
> also manually ran "ps wwwaux >> ps.txt" periodically.  This second
> output is not overly helpful, because the system was swapping and
> unuseable for the times when the 'ps' output would be most useful.

Sorry, I forgot to mention that OOM killer kicked in twice.  You can
probably pick out the points where it kicked in, in the vmstat output.

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |

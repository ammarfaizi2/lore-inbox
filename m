Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267275AbTAVMb0>; Wed, 22 Jan 2003 07:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267449AbTAVMb0>; Wed, 22 Jan 2003 07:31:26 -0500
Received: from elin.scali.no ([62.70.89.10]:27399 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S267275AbTAVMbZ>;
	Wed, 22 Jan 2003 07:31:25 -0500
Subject: Re: sleep in asm
From: Terje Eggestad <terje.eggestad@scali.com>
To: Electroniks New <elektr_new@yahoo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030122113050.65639.qmail@web14707.mail.yahoo.com>
References: <20030122113050.65639.qmail@web14707.mail.yahoo.com>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1043239231.2048.9.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 22 Jan 2003 13:40:31 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


a) a little but of math helps, on a 1GHz pentium 16000 nops is only
about 5-6 usecs. This is superscalar machines that do three inst per
clock.

b) are you in user space or kernel space?

c) if the answer in b) is that your doing some embedded stuff, you Q on
if it matter if you're in real or protected mode indicate that, then
you're on the wrong mailing list. pls stop posting .

d) 1 sec cpu time, or wall time?

e) do you want to sleep, or burn CPU cycles?

f) why assembly?

 

On ons, 2003-01-22 at 12:30, Electroniks New wrote:
> Hi,
>   What is the equivalent of sleep in assembly.
>   I tried jmps and nops i even kept loops.for jumps
> and nops but all in vain .
>   Does it make any difference if i am doing this real
> mode instead of pmode ? doesnt the functions nop and
> jmps   do what they are supposed to do . 16000 nops
> doesn't sleep for 1 sec.
> 
> Any help would be appreciated. 
> 
> __________________________________________________
> Do you Yahoo!?
> Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
> http://mailplus.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267034AbRGILkQ>; Mon, 9 Jul 2001 07:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267036AbRGILkG>; Mon, 9 Jul 2001 07:40:06 -0400
Received: from mail.necsom.com ([195.197.180.67]:921 "EHLO
	mail.services.necsom.com") by vger.kernel.org with ESMTP
	id <S267034AbRGILjx>; Mon, 9 Jul 2001 07:39:53 -0400
To: Ville Nummela <ville.nummela@mail.necsom.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Andrea Arcangeli <andrea@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: tasklets in 2.4.6
In-Reply-To: <7an16iy2wa.fsf@necsom.com> <3B4563D5.89A1ACA3@mandrakesoft.com>
	<3B45760D.6F99149C@mandrakesoft.com> <7aelrqxycn.fsf@necsom.com>
X-Face: "Df%<nszNB6]!2E>ff/A[8\G2b3+^!5to-ud=~>-GK'R3S00Csb"a2XD}:"E8Y(ZS4|d#5d!]Y];+I+8(L;jzZM`?M5$QkA>C@"?Y5@&^):)@<_S|q_*v$dgZYh%-Kw<_g,9pmme24Zr|d;dvwK}}.1,K!uP)/mX\=1IhOn7Lvr=k$">br]sxlslZ8m%g,v'y/l`X5oObnS)C^q<:DTgvV^|&`QuPHF]YZJ8`q|z^mkeP,.['pv1eMZzflI4RE|1}t&{Pp'c-M;t~@T2L$$YtuFzM$`P~aN48_ohw:KbSYPvx]:IBS`\g
From: Ville Nummela <ville.nummela@mail.necsom.com>
Date: 09 Jul 2001 14:39:46 +0300
In-Reply-To: <7aelrqxycn.fsf@necsom.com> (Ville Nummela's message of "09 Jul 2001 12:09:44 +0300")
Message-ID: <7a8zhyxrel.fsf@necsom.com>
User-Agent: Gnus/5.090002 (Oort Gnus v0.02) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Nummela <ville.nummela@mail.necsom.com> writes:

> Jeff Garzik <jgarzik@mandrakesoft.com> writes:
> > As I hacked around to fix this, I noticed Andrea's ksoftirq patch
> > already fixed this.  So, I decided to look over his patch instead.
> I tried that patch too, but with not so good results: The code LOOKS good to
> mee too, but for some reason it still seems to stuck in looping the tasklet
> code only. btw. I'm trying this on PPC, it might have something to do with
> that.. :)

Stupid is stupid does.. I had used Adreas patch for a wrong kernel version,
and therefore the patch hadn't quite succeeded. The right patch works well
on the PPC too :-)

-- 
 |   ville.nummela@necsom.com tel: +358-40-8480344               
 |   So Linus, what are we doing tonight?                             
 |   The same thing we every night Tux. Try to take over the world!   

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVASAqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVASAqr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 19:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVASAqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 19:46:47 -0500
Received: from lakermmtao10.cox.net ([68.230.240.29]:55443 "EHLO
	lakermmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261512AbVASAq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 19:46:27 -0500
In-Reply-To: <Pine.LNX.4.44.0501181616090.15507-100000@sasami.anime.net>
References: <Pine.LNX.4.44.0501181616090.15507-100000@sasami.anime.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8A2B802C-69B3-11D9-AC4F-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Fruhwirth Clemens <clemens@endorphin.org>, linux-kernel@vger.kernel.org,
       Bill Davidsen <davidsen@tmr.com>,
       Paul Walker <paul@black-sun.demon.co.uk>,
       Andries Brouwer <aebr@win.tue.nl>, linux-crypto@nl.linux.org,
       Venkat Manakkal <venkat@rayservers.com>,
       Jari Ruusu <jariruusu@users.sourceforge.net>,
       James Morris <jmorris@redhat.com>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Announce loop-AES-v3.0b file/swap crypto package
Date: Tue, 18 Jan 2005 19:46:22 -0500
To: Dan Hollis <goemon@anime.net>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 18, 2005, at 19:18, Dan Hollis wrote:
> On Tue, 18 Jan 2005, Venkat Manakkal wrote:
>> As for cryptoloop, I'm sorry, I cannot say the same. The password 
>> hashing
>> system being changed in the past year, poor stability and machine 
>> lockups are
>> what I have noticed, besides there is nothing like the readme here:
>
> cryptoloop is also unusably slow, even on my x86_64 machines...
>
> at the very least someone should merge in the assembler loop-aes 
> routines.
> all other architectural arguments/whining aside, is there any good 
> reason
> not to do this?

As far as I am aware, from monitoring the various threads of this 
discussion for a
few years, the only reason is that nobody has compiled and submitted a 
set of
small, discreet, and obvious patches.  I suspect if someone were to do 
that, it
would be applied without much fuss or whining.  The primary complaints 
against
loop-AES WRT merging it (or any subset) with the mainstream kernel was 
that it
is a single bigdiff, with no real subdivision.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------



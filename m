Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbREETiN>; Sat, 5 May 2001 15:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135276AbREETiE>; Sat, 5 May 2001 15:38:04 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:31749 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129242AbREETh4>; Sat, 5 May 2001 15:37:56 -0400
Date: Sat, 5 May 2001 21:37:44 +0200
From: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 fork() problems (maybe)
Message-ID: <20010505213744.B1809@lisa.links2linux.home>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <00fb01c0d596$afb30690$020a0a0a@totalmef>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00fb01c0d596$afb30690$020a0a0a@totalmef>; from mag@fbab.net on Sat, May 05, 2001 at 09:07:53PM +0200
X-Operating-System: Linux 2.2.18-lisa01 i586
X-Editor: VIM 5.7.8
X-Homepage: http://www.links2linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Magnus Naeslund(f) schrieb am 05.05.01 um 21:07 Uhr:
> Hello, I saw that there was something changed on how fork() works, and
> wonder if this could be the cause my problem.
> When i do a "su - <user>" it just hangs.
> When i run strace on it i see that it forks and wait()s on the child.
> 
> Sometimes when i strace the su command it succeeds to give me a shell,
> sometimes not.
> But it allways fails when i don't strace it.
> 

Hi Magnus,

use 2.4.5-pre1 instead, Linus has undone the fork()-change for some
reason ;-)

Cheers
-Marc


-- 
+-O . . . o . . . O . . . o . . . O . . .  ___  . . . O . . . o .-+
| Ein neuer Service von Links2Linux.de:   /  o\   RPMs for SuSE   |
| --> PackMan! <-- naeheres unter        |   __|   and  others    |
| http://packman.links2linux.de/ . . . O  \__\  . . . O . . . O . |

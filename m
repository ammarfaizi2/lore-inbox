Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267041AbSIRPdM>; Wed, 18 Sep 2002 11:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267052AbSIRPdM>; Wed, 18 Sep 2002 11:33:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:23570 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267041AbSIRPdL>; Wed, 18 Sep 2002 11:33:11 -0400
Date: Wed, 18 Sep 2002 12:37:57 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Cort Dougan <cort@fsmlabs.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Andries Brouwer <aebr@win.tue.nl>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <20020918090104.E14918@host110.fsmlabs.com>
Message-ID: <Pine.LNX.4.44L.0209181237220.1519-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2002, Cort Dougan wrote:

> Can we get a lockless, scalable, fault-tolerant, pre-emption safe,
> zero-copy and distributed get_pid() that meets the Carrier Grade
> specification?  If at all possible I need it to do garbage collection, too.

Anything better than a get_pid() that triggers the NMI oopser
when wli runs tiobench with 1024 threads ;)

Rik
-- 
Spamtrap of the month: september@surriel.com

http://www.surriel.com/		http://distro.conectiva.com/


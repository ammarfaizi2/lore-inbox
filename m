Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269395AbRHNTFY>; Tue, 14 Aug 2001 15:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269435AbRHNTFN>; Tue, 14 Aug 2001 15:05:13 -0400
Received: from amicus.delamancha.org ([216.7.21.37]:15628 "HELO
	amicus.delamancha.org") by vger.kernel.org with SMTP
	id <S269395AbRHNTEy>; Tue, 14 Aug 2001 15:04:54 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>, <kernelnewbies@nl.linux.org>
Subject: Re: WANTED: Re: VM lockup with 2.4.8 / 2.4.8pre8
In-Reply-To: <Pine.LNX.4.33L.0108131451470.6118-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108131451470.6118-100000@imladris.rielhome.conectiva>
 (Rik van Riel's message of "Mon, 13 Aug 2001 14:55:42 -0300 (BRST)")
From: "Jon 'tex' Boone" <tex@delamancha.org>
Date: Tue, 14 Aug 2001 15:04:59 -0400
Message-ID: <m38zgmpin8.fsf@amicus.delamancha.org>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> CALL FOR VOLUNTEERS
> ---------------------
> This means the OOM killer should be tuned, or more precisely,
> the code deciding when the OOM killer kicks in should be tuned.
> 
> The code involved is very easy, so I'll explain it a bit and
> ask for volunteers to tweak the code and fix the OOM behaviour.
> 
> The functions/places you may want to tweak are:
> 
> mm/vmscan.c::kswapd()
> 	else if (out_of_memory()) {
> 		oom_kill()
> 
> mm/oom_kill.c::out_of_memory()

Rik,

    Should said volunteer(s) work with stock 2.4.8?

-tex
-- 
------------------
Jon Allen Boone
tex@delamancha.org

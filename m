Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268926AbRIRMFB>; Tue, 18 Sep 2001 08:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269318AbRIRMEl>; Tue, 18 Sep 2001 08:04:41 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:25864 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S268926AbRIRMEd>;
	Tue, 18 Sep 2001 08:04:33 -0400
Date: Tue, 18 Sep 2001 09:04:12 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <Pine.LNX.4.33.0109170840520.8836-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0109180901580.14288-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2001, Linus Torvalds wrote:

> We should not do _anything_ in __find_page_nolock().

> The aging has to be done at a higher level (ie when you actually _use_
> it, not when you search the hash queues).

Absolutely agreed. In fact, I already did this last week
in the -still not published- new version of the reverse
mapping patch ;)

(now if I only could get that thing SMP safe in an efficient
way)

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


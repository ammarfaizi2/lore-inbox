Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273309AbRIUMKf>; Fri, 21 Sep 2001 08:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273463AbRIUMKZ>; Fri, 21 Sep 2001 08:10:25 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:62994 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S273309AbRIUMKJ>;
	Fri, 21 Sep 2001 08:10:09 -0400
Date: Fri, 21 Sep 2001 09:10:23 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Rob Fuller <rfuller@nsisoftware.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <20010921080549Z16344-2758+350@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0109210909260.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001, Daniel Phillips wrote:

> Have you tried making the down increment larger and the up increment
> smaller when the active list is larger?

This would make the page age of pages referenced in the page
tables smaller, not larger. And we already know that decreasing
the page age of heavily referenced pages isn't good.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


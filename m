Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272681AbRIVDKN>; Fri, 21 Sep 2001 23:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272682AbRIVDKD>; Fri, 21 Sep 2001 23:10:03 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:31755 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S272681AbRIVDJu>;
	Fri, 21 Sep 2001 23:09:50 -0400
Date: Sat, 22 Sep 2001 00:09:54 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Alexander Viro <viro@math.psu.edu>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rob Fuller <rfuller@nsisoftware.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <Pine.GSO.4.21.0109212151590.9760-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33L.0109212351160.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001, Alexander Viro wrote:

> It means that you prefer system dying under much lighter load.  At
> some point any box will get into feedback loop,

> The question being, at which point will it happen and how graceful
> will the degradation be when we get near that point.

And ... what do we do when we reach that point ?

It's obvious that we need load control to make the machine
survive at that point; load control is a horrible measure
which will make interactivity very bad, but will cause the
box to survive where otherwise it would be thrashing.

Having a better paging system would mean having the 'thrashing
point' (where we need to kick in load control' much further
out and being able to keep the system behave better under
heavier VM loads.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


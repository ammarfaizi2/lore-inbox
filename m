Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311563AbSCNOAE>; Thu, 14 Mar 2002 09:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311621AbSCNN7z>; Thu, 14 Mar 2002 08:59:55 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:39941 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S311619AbSCNN7u>;
	Thu, 14 Mar 2002 08:59:50 -0500
Date: Thu, 14 Mar 2002 10:59:12 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: wli@holomorphy.com, Andrea Arcangeli <andrea@suse.de>,
        <wli@parcelfarce.linux.theplanet.co.uk>,
        <linux-kernel@vger.kernel.org>, <hch@infradead.org>,
        <phillips@bonn-fries.net>
Subject: Re: 2.4.19pre2aa1
In-Reply-To: <Pine.LNX.3.95.1020314071041.3534A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44L.0203141056180.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, Richard B. Johnson wrote:

> [SNIPPED rest of diatribe...]
>
> Listen you incompetent amoeba.

Likewise.  Lets go over this again:

1) the idea is to have a hashing function that
   performs well for the page cache and/or the
   hashed wait queues

2) input for these two hash functions is not at
   all guaranteed to be random or uniformly spread

3) this means we need a hash function that performs
   well on very much non-random inputs

Now, where does your random number generator fit in this
scenario ?

regards,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/



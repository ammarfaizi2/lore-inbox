Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292466AbSCDQ3j>; Mon, 4 Mar 2002 11:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292485AbSCDQ3b>; Mon, 4 Mar 2002 11:29:31 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:6413 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S292482AbSCDQ3V>;
	Mon, 4 Mar 2002 11:29:21 -0500
Date: Mon, 4 Mar 2002 13:28:58 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <20020304171030.K20606@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0203041327510.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002, Andrea Arcangeli wrote:

> > you care about how well the VM chooses which pages to swap out
> > and which pages to keep in RAM.
>
> and for that the aging fair scan for the acessed bitflag has a chance to
> be better than the unfair accessed bit handling in rmap that can lead to
> not evaluating correctly the accessed-virtual-age of the pages.

Ummm, what do you mean by this ?

> Also threating mapped pages in a special manner is beneficial.

Note that -rmap already does this.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289047AbSAUFfg>; Mon, 21 Jan 2002 00:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289049AbSAUFf0>; Mon, 21 Jan 2002 00:35:26 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:13331 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289047AbSAUFfG>;
	Mon, 21 Jan 2002 00:35:06 -0500
Date: Mon, 21 Jan 2002 03:34:14 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Adam Kropelin <akropel1@rochester.rr.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18pre3-ac1
In-Reply-To: <200201210530.g0L5UQu20723@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33L.0201210333460.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2002, Richard Gooch wrote:

> Will lazy page table instantiation speed up fork(2) without rmap?
> If so, then you've got a problem, because rmap will still be slower
> than non-rmap. Linus will happily grab any speedup and make that the
> new baseline against which new schemes are compared :-)

I guess the difference here is "optimised for lmbench"
vs. "optimised to be stable in real workloads"  ;)

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/


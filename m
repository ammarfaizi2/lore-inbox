Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271673AbRIJUjw>; Mon, 10 Sep 2001 16:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271676AbRIJUjn>; Mon, 10 Sep 2001 16:39:43 -0400
Received: from colin.muc.de ([193.149.48.1]:39692 "HELO colin.muc.de")
	by vger.kernel.org with SMTP id <S271673AbRIJUjV>;
	Mon, 10 Sep 2001 16:39:21 -0400
Message-ID: <20010910224002.31693@colin.muc.de>
Date: Mon, 10 Sep 2001 22:40:02 +0200
From: Andi Kleen <ak@muc.de>
To: kuznet@ms2.inr.ac.ru
Cc: tao@acc.umu.se, matthias.andree@gmx.de, alan@lxorguk.ukuu.org.uk,
        wietse@porcupine.org, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
In-Reply-To: <20010910100537.W26627@khan.acc.umu.se> <200109101936.XAA00707@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
In-Reply-To: <200109101936.XAA00707@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Mon, Sep 10, 2001 at 09:36:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2001 at 09:36:20PM +0200, kuznet@ms2.inr.ac.ru wrote:
> And I see no reasons to refuse this: it evidently improves the things
> almost without efforts. 

Doubtful.

> No matter that this imporvement is not so useful,
> as it would happen if I guessed this way from the very beginning.

That's a polite way to express it.

> So that applications will have to worry about compatibility with older
> kernels in any case.

Just hope then that no ifconfig or other binary has a two on the stack
when calling this.

-Andi

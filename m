Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272401AbRIKL0R>; Tue, 11 Sep 2001 07:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272415AbRIKL0H>; Tue, 11 Sep 2001 07:26:07 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:24076 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S272401AbRIKLZz>; Tue, 11 Sep 2001 07:25:55 -0400
Date: Tue, 11 Sep 2001 13:26:15 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010911132615.F4757@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010910100537.W26627@khan.acc.umu.se> <200109101936.XAA00707@ms2.inr.ac.ru> <20010910224002.31693@colin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010910224002.31693@colin.muc.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2001, Andi Kleen wrote:

> Just hope then that no ifconfig or other binary has a two on the stack
> when calling this.

One more reply to this, I inserted some debugging info, and all
addresses that the kernel saw on this ioctl so far are:

127.0.0.1
the machine's address
the machine's broadcast address
85.85.85.85 which I used in testing Postfix' patches
192.255.255.255 <- that's a piece of junk
192.168.0.222 <- that's a piece of junk

I already used ifconfig on that machine to display configuration data.

I'll see if other addresses turn up.

-- 
Matthias Andree

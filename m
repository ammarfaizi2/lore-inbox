Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263070AbRFYJdv>; Mon, 25 Jun 2001 05:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263167AbRFYJdm>; Mon, 25 Jun 2001 05:33:42 -0400
Received: from nef.ens.fr ([129.199.96.32]:43789 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S263070AbRFYJd2>;
	Mon, 25 Jun 2001 05:33:28 -0400
Date: Mon, 25 Jun 2001 11:33:25 +0200
From: Thomas Pornin <Thomas.Pornin@ens.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: GCC3.0 Produce REALLY slower code!
Message-ID: <20010625113325.A3995@bolet.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0106250142070.1314-100000@Expansa.sns.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0106250142070.1314-100000@Expansa.sns.it> you write:
> All bench i did, it's slower about 3/5% depending on the kind of code.

On Alpha machines (ev4 and ev56), it seems actually to be the opposite
on integer calculation: gcc-3.0 produces code up to 5% faster than
gcc-2.95.2. The result is still 25% behind the Compaq C compiler,
though.

By the way, the installation procedure is mostly buggy on old Alpha
systems (RedHat 5.1 -> binutils 2.9, glibc 2.0.7). I do not mind gcc
having some requirements about versions of such other tools, but it
could be made a bit more explicit, and the configuration script should
also emit some warnings (it detects the versions installed, it just does
not bother reporting the potential problem).


	--Thomas Pornin

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271129AbRIJPMK>; Mon, 10 Sep 2001 11:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271182AbRIJPMA>; Mon, 10 Sep 2001 11:12:00 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:15634 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S271129AbRIJPLs>; Mon, 10 Sep 2001 11:11:48 -0400
Date: Mon, 10 Sep 2001 17:12:08 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010910171208.B26229@maggie.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010906181826.9CCECBC06C@spike.porcupine.org> <E15f55T-0000Kc-00@the-village.bc.nu> <20010906221359.G13547@emma1.emma.line.org> <20010910100537.W26627@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010910100537.W26627@khan.acc.umu.se>; from tao@acc.umu.se on Mon, Sep 10, 2001 at 10:05:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2001, David Weinehall wrote:

> Please accept, that sometimes, just sometimes, there is a superior way
> to do something, and implementing support for that might not be such
> a bad idea after all. Whining about this causing "bloat and maintainance
> nightmares" (no, not a direct quote, sorry for that) doesn't cut it,
> because there are probably more Linux-machines running the software than
> any BSD-machines, thus the netlink-code will get _more_ testing than
> the legacy API.

Dave, that's just not the point, the application would have to offer TWO
interfaces, one for Linux, and one for the legacy API. The legacy API is
trivial and can be viewed in the kernel or in the application.

When the legacy API can fulfill the need with, after all, two or three
lines of code added, then there is no need to add two hundred of them to
the application.

Anyways, Alexey said the patch was correct, so it has been submitted to
Alan, Linus and Wietse, no matter what. The administrator or the
distributor can always choose to add the patch no matter what you say or
think. Show a bug in the patch, show an incompatibility cause, or remain
quiet. Please.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131627AbRDCMvV>; Tue, 3 Apr 2001 08:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131474AbRDCMvM>; Tue, 3 Apr 2001 08:51:12 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:24266 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S131461AbRDCMu5>; Tue, 3 Apr 2001 08:50:57 -0400
Message-ID: <3AC9C577.920036CD@coplanar.net>
Date: Tue, 03 Apr 2001 08:43:36 -0400
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: David Lang <dlang@diginsite.com>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Ian Soboroff <ian@cs.umbc.edu>, linux-kernel@vger.kernel.org
Subject: Re: /proc/config idea
In-Reply-To: <E14kPuE-0007xK-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > a module for 2.4.3 will work for any 2.4.3 kernel that supports modules
> > at all (except for the SMP vs UP issue) so it's not the same thing as
> > trying to figure out which if the 2.4.3 kernels matches what you are
> > running.
>
> Nope. The 2.4 kernel ABI depends upon a mixture of config options including the
> cpu type, as well as the compiler version being used. The API is intended to
> be constant throughout 2.4 (but isnt yet totally solid due to bug fixing
> activity). We don't care about the ABI because we are source code based
>

Is it possible to identify *all* the dependencies and include symbols (or by some
other
method) have these dependencies checked by insmod?  It would be simply
smashing to have it all inherently bullet proof. (i know never say never, but
lower maintenance then or simpler for users or something)


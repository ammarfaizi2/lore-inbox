Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266609AbSL2NTF>; Sun, 29 Dec 2002 08:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266615AbSL2NTF>; Sun, 29 Dec 2002 08:19:05 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:22689 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S266609AbSL2NTE>; Sun, 29 Dec 2002 08:19:04 -0500
Subject: Re: Radeonfb and the new kernel 2.4.21
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: messor <krystian@poczta.fm>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0212291048490.190-100000@slackware.linux.net>
References: <Pine.LNX.4.44.0212291048490.190-100000@slackware.linux.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 29 Dec 2002 14:29:24 +0100
Message-Id: <1041168564.583.18.camel@zion>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-29 at 11:08, messor wrote:
> 
> Hi,
> Could I request about something ???
> In Poland in last few days we have a very hard
> conversation about radeonfb. Some people have
> a huge problem with that. They can force radeonfb
> to work, but they cannot change display timings.
> Using fbset cause monitor to turn off.
> We know that the answer is in Alans Cox kernel 2.4.20-rc2-ac3.
> Could I request to include some solution to the
> new kernel 2.4.21 or something like that ????
> 
> I hope my terrible english will not provoke You
> to forget about this e-mail.

Can you try the version in my PowerMac tree ?

You can get it via rsync via

rsync rsync.penguinppc.org::linux-2.4-benh/drivers/video/radeonfb.c .
rsync rsync.penguinppc.org::linux-2.4-benh/drivers/video/radeon.h .

If not, then I'll have to check again what's in Alan's version. You can
also bug the maintainer (Ani Joshi), you may be lucky... :)

Ben.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316957AbSFQT3i>; Mon, 17 Jun 2002 15:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316958AbSFQT3h>; Mon, 17 Jun 2002 15:29:37 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:61116 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S316957AbSFQT3h>;
	Mon, 17 Jun 2002 15:29:37 -0400
Date: Mon, 17 Jun 2002 21:25:51 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200206171925.VAA08686@harpo.it.uu.se>
To: kai@tp1.ruhr-uni-bochum.de
Subject: Re: 2.5.22 broke modversions
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002 09:30:13 -0500 (CDT), Kai Germaschewski wrote:
>> Something in the 2.5.22 Makefile/Rule.make changes broke
>> modversions on my P4 box. ...
>
>You're right, thanks for the report. The fix is appended ;)

Thanks. The fix worked fine for me.

>(Whenever a .ver file is updated, include/linux/modversions.h is touched,
> so that during the build make only needs to check the timestamp
> of modversions.h instead of all the individual .ver files - do you see a
> problem with that?)

Nope, that should be ok.

/Mikael

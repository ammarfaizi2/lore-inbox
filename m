Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274566AbRITRKf>; Thu, 20 Sep 2001 13:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274567AbRITRKZ>; Thu, 20 Sep 2001 13:10:25 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:9225 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id <S274566AbRITRKV>;
	Thu, 20 Sep 2001 13:10:21 -0400
Message-Id: <200109201710.f8KHAcY45233@aslan.scsiguy.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre10 aic7xxx problem 
In-Reply-To: Your message of "Thu, 20 Sep 2001 17:54:52 +0200."
             <20010920155452.15612@smtp.adsl.oleane.com> 
Date: Thu, 20 Sep 2001 11:10:38 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi Justin !
>
>I'm having a problem with the aic7xxx driver in 2.4.10pre10, it used to
>work fine with 2.4.10pre8. The card is a 2960 single channel SCSI2, the
>drive is a SEAGATE ST34520N rev. 1444.
>Weirdly, the 2 drivers have the same rev. (maybe you didn't change it ?),

If the version number didn't change, then the kernels are using the same
driver.  I haven't been tracking the 2.4.10pre series, so I don't even
know what version is in there.

Please upgrade to v6.2.3.  By default it will dump lots of interesting
debug info when a timeout occurs.  You may need to use a serial console
to catch all of it.  The driver can be found here:

http://people.FreeBSD.org/~gibbs/linux/

--
Justin

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279840AbRKPAnw>; Thu, 15 Nov 2001 19:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281193AbRKPAnm>; Thu, 15 Nov 2001 19:43:42 -0500
Received: from mail313.mail.bellsouth.net ([205.152.58.173]:3568 "EHLO
	imf13bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279840AbRKPAnc>; Thu, 15 Nov 2001 19:43:32 -0500
Message-ID: <3BF46114.C73D4C00@mandrakesoft.com>
Date: Thu, 15 Nov 2001 19:43:00 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Francois Romieu <romieu@cogenit.fr>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.4.15-pre4 - recovery after timeout (drivers/net/fealnx.c)
In-Reply-To: <20011115222702.A14955@se1.cogenit.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, patch applied.

Yes, the tx reset is gross, but recovery after timeout is important.  It
is very complicated to test and reset each of the various NIC engines as
necessary in a proper tx_timeout routine, so most drivers go the lazy
way and simply reset the entire NIC.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno


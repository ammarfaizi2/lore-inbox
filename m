Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQKMC6s>; Sun, 12 Nov 2000 21:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129145AbQKMC6i>; Sun, 12 Nov 2000 21:58:38 -0500
Received: from james.kalifornia.com ([208.179.0.2]:22894 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S129103AbQKMC6Z>; Sun, 12 Nov 2000 21:58:25 -0500
Message-ID: <3A0F58CA.22F22844@linux.com>
Date: Sun, 12 Nov 2000 18:58:18 -0800
From: David Ford <david@linux.com>
Reply-To: david+validemail@kalifornia.com
Organization: Talon Technology, Intl.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
CC: root@chaos.analogic.com, Andrea Arcangeli <andrea@suse.de>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in 
 /var/spool/mqueue]
In-Reply-To: <200011120139.eAC1d2E30929@sleipnir.valparaiso.cl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have found that lowering the MTU helps a lot.  If it is a particular route,
simply add an additional route with the lower limit set.  The tradeoff of
efficiency v.s. reliability is improved.

-d

Horst von Brand wrote:

> In my experience, if you try to send large messages over unreliable
> networks (we sometimes see 50 or more % losses due to chronical link

-- ---NOTICE

-- fwd: fwd: fwd: type emails will be deleted automatically.
      "There is a natural aristocracy among men. The grounds of this are
      virtue and talents", Thomas Jefferson [1742-1826], 3rd US President



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

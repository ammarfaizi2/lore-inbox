Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131152AbQLRJNC>; Mon, 18 Dec 2000 04:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131238AbQLRJMx>; Mon, 18 Dec 2000 04:12:53 -0500
Received: from nef.ens.fr ([129.199.96.32]:9742 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S131152AbQLRJMo>;
	Mon, 18 Dec 2000 04:12:44 -0500
Date: Mon, 18 Dec 2000 09:42:10 +0100
From: Thomas Pornin <Thomas.Pornin@ens.fr>
To: igor.mozetic@uni-mb.si
Cc: linux-kernel@vger.kernel.org
Subject: Re: mount and 2.2.18
Message-ID: <20001218094210.A14020@bolet.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <14909.17707.4868.460585@cmb1-3.dial-up.arnes.si>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <14909.17707.4868.460585@cmb1-3.dial-up.arnes.si> you write:
> Is this harmless or do I need the latest mount?

The latest mount is needed only for NFSv3 support. As long as you do
only NFSv2, there is no problem (except the message, you will get it
once per mounting).

But NFSv3 is great; if your server is NFSv3 aware, I suggest you shift
your client to NFSv3 as well. It rocks.


	--Thomas Pornin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

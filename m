Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131014AbRAWMgx>; Tue, 23 Jan 2001 07:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131045AbRAWMgn>; Tue, 23 Jan 2001 07:36:43 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:41039 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S131014AbRAWMgd>; Tue, 23 Jan 2001 07:36:33 -0500
Message-ID: <3A6D7AC5.673D2DE@linux.com>
Date: Tue, 23 Jan 2001 12:36:21 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: NETDEV timeout on tulips [was: Re: 2.4.1-test10]
In-Reply-To: <Pine.LNX.4.10.10101221711560.1309-100000@penguin.transmeta.com> <3A6CF5B7.57DEDA11@linux.com> <3A6D2D54.619AFA7E@mandrakesoft.com> <3A6D616F.63EB34A6@linux.com> <20010123125636.I25659@mea-ext.zmailer.org> <3A6D676C.2F6D5236@linux.com> <20010123142550.J25659@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:

>   I think they are separate problems.
>   The first is power-management suspend/resume issue, and possibly
>   PCMCIA problem at software re-insert of card (which never was taken
>   out *physically*).
>
>   If I pull the cardbus card out, make sure the  "dhcpcd eth0" has
>   died (e.g. I kill it), and re-insert the card, system is highly
>   likely to work.

In my cardbus instance, a simple cardctl eject/insert is sufficient, I don't need
to manually cycle it.

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

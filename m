Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278698AbRJTALg>; Fri, 19 Oct 2001 20:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278700AbRJTAL0>; Fri, 19 Oct 2001 20:11:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39940 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278698AbRJTALV>; Fri, 19 Oct 2001 20:11:21 -0400
Date: Fri, 19 Oct 2001 17:09:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Patrick Mochel <mochel@osdl.org>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <20011019233322.26154@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0110191708220.2646-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 20 Oct 2001, Benjamin Herrenschmidt wrote:
>
> Reading about the suspend to disk issue, and thinking about
> some of pmac needs, I tend to stil think we have overlooked
> that ordering issue.

Why?

If there is some ordering inherent in the bus, that has to be shown in the
bus structure. Why would you EVER care about order between devices that
are independent?

		Linus


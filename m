Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287598AbRLaSvg>; Mon, 31 Dec 2001 13:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287599AbRLaSv1>; Mon, 31 Dec 2001 13:51:27 -0500
Received: from ns.ithnet.com ([217.64.64.10]:56337 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S287598AbRLaSvR>;
	Mon, 31 Dec 2001 13:51:17 -0500
Date: Mon, 31 Dec 2001 19:51:15 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Klaus Zerwes <kzerwes@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug ?
Message-Id: <20011231195115.410b871f.skraw@ithnet.com>
In-Reply-To: <3C30A9F0.3070603@web.de>
In-Reply-To: <3C30A9F0.3070603@web.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2001 19:09:52 +0100
Klaus Zerwes <kzerwes@web.de> wrote:

> My PC hangs sporadicaly (every 2 weeks) after heavy Network traffic.
> I tried to work around the problem by changing the NIC (dmfe > 
> realtek, using new driver 8139too), but it din't help.

Hm, I think I saw something the like. The configuration was basically SuSE 7.3
(with 2.4.10-whatever kernel) and two Realtek cards in a not-trusted cheap box.
I saw a good amount of collisions on the network, too. I replaced the Realteks
with DLink and the kernel with 2.4.16 and it did not happen again, although the
network collisions stayed the same. I tend to think it is the old kernel, but I
don't like Realtek cards anyway, so I threw them out in one go.

Tell us if it happens again with 2.4.17, or if you are sure it does not,
declare it as solved.

Regards,
Stephan


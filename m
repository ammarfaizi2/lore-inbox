Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129188AbQKMS7F>; Mon, 13 Nov 2000 13:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129100AbQKMS6y>; Mon, 13 Nov 2000 13:58:54 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:14604 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129188AbQKMS6o>;
	Mon, 13 Nov 2000 13:58:44 -0500
Date: Mon, 13 Nov 2000 10:59:31 -0800
From: David Hinds <dhinds@valinux.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd)
Message-ID: <20001113105931.C1587@valinux.com>
In-Reply-To: <3A1009DB.CC98CE06@mandrakesoft.com> <3A10031B.79D8A9B5@mandrakesoft.com> <3A0FF138.A510B45@mandrakesoft.com> <7572.974120930@redhat.com> <20554.974126251@redhat.com> <26373.974128444@redhat.com> <3A1009DB.CC98CE06@mandrakesoft.com> <29549.974130154@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
In-Reply-To: <29549.974130154@redhat.com>; from David Woodhouse on Mon, Nov 13, 2000 at 03:42:34PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2000 at 03:42:34PM +0000, David Woodhouse wrote:

> It's the socket drivers which _aren't_ in the kernel source which are most
> likely to exhibit this problem. Anything in the kernel tree was probably
> converted by Linus, and hence done right. As there are so few socket drivers
> in his tree, the amount of code duplication wasn't immediately obvious
> either.

The i82365 and tcic drivers in the 2.4 tree have not been converted to
use the thread stuff; as far as I know, the yenta driver is the only
socket driver that works at all in 2.4.

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

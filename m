Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135533AbRANVqG>; Sun, 14 Jan 2001 16:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135564AbRANVp4>; Sun, 14 Jan 2001 16:45:56 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:7547
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S135533AbRANVpj>; Sun, 14 Jan 2001 16:45:39 -0500
Date: Sun, 14 Jan 2001 22:45:31 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Roman.Hodek@informatik.uni-erlangen.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make drivers/scsi/atari_scsi.c check request_irq (240p3)
Message-ID: <20010114224531.G602@jaquet.dk>
In-Reply-To: <20010114195323.B602@jaquet.dk> <3A621A27.685B985E@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3A621A27.685B985E@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, Jan 14, 2001 at 04:29:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 04:29:11PM -0500, Jeff Garzik wrote:
> request_irq returns zero on success, not on failure.  Further, you need
> to return the request_irq error value back to the caller, if possible.

<choke><blush>

My, that was embarassing. I'll change this as soon as I trust myself
with a keyboard again :)

Thank you for the catch.
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"If you aim the gun at your foot and pull the trigger, it's UNIX's job to 
ensure reliable delivery of the bullet to where you aimed the gun (in
this case, Mr. Foot)." -- Terry Lambert, FreeBSD-Hackers mailing list.

PS: Welcome back. I hope your wrists have got all the rest they needed.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293015AbSBVV4r>; Fri, 22 Feb 2002 16:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293016AbSBVV4h>; Fri, 22 Feb 2002 16:56:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8970 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293015AbSBVV4Z>;
	Fri, 22 Feb 2002 16:56:25 -0500
Message-ID: <3C76BE88.B082831E@mandrakesoft.com>
Date: Fri, 22 Feb 2002 16:56:24 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: G?rard Roudier <groudier@free.fr>, Arjan van de Ven <arjanv@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <20020222154011.B5783@suse.cz> <20020221211606.F1418-100000@gerard> <20020222223444.A7238@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> For some adapters, this is possible, for other it is not (at all). You
> happen to be a maintainer of one for which it is possible, and thus your
> point of view is quite different from mine - mine comes from USB and
> other parts of the device world, where no order can even be defined.
> 
> And because of that, I do not think that having the host adapters decide
> what device gets what number is a good idea. They should provide the
> information if they have it, but the final decision should definitely be
> done in userspace, by the hotplug agent.
> 
> Ie. it should be configurable.

For the future, we need to get away from legacy methods of disk
ordering, indeed.

For Gerard's case, I can see a userspace agent running in initramfs
discovering the order...

Most filesystems have some sort of serial number of labelling capability
which allows them to be addressed independent of spindle, or starting
position on that spindle [partition].

-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |

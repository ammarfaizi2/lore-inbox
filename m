Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293018AbSBVWC1>; Fri, 22 Feb 2002 17:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293019AbSBVWCR>; Fri, 22 Feb 2002 17:02:17 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:39947 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S293018AbSBVWCD>; Fri, 22 Feb 2002 17:02:03 -0500
Date: Fri, 22 Feb 2002 22:59:49 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: G?rard Roudier <groudier@free.fr>, Arjan van de Ven <arjanv@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
Message-ID: <20020222225949.J7238@suse.cz>
In-Reply-To: <20020222154011.B5783@suse.cz> <20020221211606.F1418-100000@gerard> <20020222223444.A7238@suse.cz> <3C76BE88.B082831E@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C76BE88.B082831E@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Feb 22, 2002 at 04:56:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 04:56:24PM -0500, Jeff Garzik wrote:
> Vojtech Pavlik wrote:
> > For some adapters, this is possible, for other it is not (at all). You
> > happen to be a maintainer of one for which it is possible, and thus your
> > point of view is quite different from mine - mine comes from USB and
> > other parts of the device world, where no order can even be defined.
> > 
> > And because of that, I do not think that having the host adapters decide
> > what device gets what number is a good idea. They should provide the
> > information if they have it, but the final decision should definitely be
> > done in userspace, by the hotplug agent.
> > 
> > Ie. it should be configurable.
> 
> For the future, we need to get away from legacy methods of disk
> ordering, indeed.

Exactly.

> For Gerard's case, I can see a userspace agent running in initramfs
> discovering the order...

The same agent that decides for the other cases - only in Gerard's case
it has more information to work with, we just have to make sure it can
access the information.

> Most filesystems have some sort of serial number of labelling capability
> which allows them to be addressed independent of spindle, or starting
> position on that spindle [partition].

Yes, yes, yes.

-- 
Vojtech Pavlik
SuSE Labs

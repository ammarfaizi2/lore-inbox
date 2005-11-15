Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbVKOWVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbVKOWVS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 17:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbVKOWVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 17:21:17 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:13352 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965044AbVKOWVE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 17:21:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gG37scVv6uhJBQVxDrsXuKkW2poMg5kt+XDYmo+5JEZFXc4C84Juhk5nsaZ6Lxy/X9v4Wce9+hBPMoYxnCGMmOWdPZDxYo1GuqI1SUdiRvFwmyW8Jjf++JeYyVpvF1XioYoeBwH3IQ2eyXEj+ytuy/4vvVqtwuv58QkPJzzsm/I=
Message-ID: <9a8748490511151421g2eb40cebyee78a88991867ac@mail.gmail.com>
Date: Tue, 15 Nov 2005 23:21:03 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Greg KH <gregkh@suse.de>
Subject: Re: [RFC] HOWTO do Linux kernel development - take 2
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <20051115210459.GA11363@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051115210459.GA11363@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/05, Greg KH <gregkh@suse.de> wrote:
> Here's an updated version of the "HOTO do Linux kernel development"
> document that I've been working on.
>
[snip]
> Here is a list of some of the different kernel trees available:
>   git trees:
>     - Kbuild development tree, Sam Ravnborg <sam@ravnborg.org>
>         kernel.org:/pub/scm/linux/kernel/git/sam/kbuild.git
>
>     - ACPI development tree, Len Brown <len.brown@intel.com>
>         kernel.org:/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git
>
>     - Block development tree, Jens Axboe <axboe@suse.de>
>         kernel.org:/pub/scm/linux/kernel/git/axboe/linux-2.6-block.git
>
>     - DRM development tree, Dave Airlie <airlied@linux.ie>
>         kernel.org:/pub/scm/linux/kernel/git/airlied/drm-2.6.git
>
>     - ia64 development tree, Tony Luck <tony.luck@intel.com>
>         kernel.org:/pub/scm/linux/kernel/git/aegl/linux-2.6.git
>
>     - ieee1394 development tree, Jody McIntyre <scjody@modernduck.com>
>         kernel.org:/pub/scm/linux/kernel/git/scjody/ieee1394.git
>
>     - infiniband, Roland Dreier <rolandd@cisco.com>
>         kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git
>
>     - libata, Jeff Garzik <jgarzik@pobox.com>
>         kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>
>     - network drivers, Jeff Garzik <jgarzik@pobox.com>
>         kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
>
>     - pcmcia, Dominik Brodowski <linux@dominikbrodowski.net>
>         kernel.org:/pub/scm/linux/kernel/git/brodo/pcmcia-2.6.git
>
>     - SCSI, James Bottomley <James.Bottomley@SteelEye.com>
>         kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git
>

As I see it, this list is almost guaranteed to a) be incomplete, b) be
outdated almost from the start, c) require often patching of your
HOWTO to keep updated when tree locations/names change or people
change email addr.

Wouldn't it be better to simply point to http://kernel.org/git for the list?
And email addresses for people can be found in CREDITS & MAINTAINERS,
why duplicate info here instead of pointing to those 2 canonical
documents?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

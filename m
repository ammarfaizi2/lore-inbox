Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129998AbQK2DoH>; Tue, 28 Nov 2000 22:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130135AbQK2Dn5>; Tue, 28 Nov 2000 22:43:57 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:6920 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S129998AbQK2Dns>; Tue, 28 Nov 2000 22:43:48 -0500
Date: Tue, 28 Nov 2000 21:13:27 -0600
To: Remi Turk <remi@a2zis.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CLONE_NAMESPACE, links for dirs and mount(2) for normal users questions
Message-ID: <20001128211327.K8881@wire.cadcamlab.org>
In-Reply-To: <3A1FFA2C.A8980FD8@a2zis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A1FFA2C.A8980FD8@a2zis.com>; from remi@a2zis.com on Sat, Nov 25, 2000 at 06:43:08PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Remi Turk]
> Do I understand correctly that this means hardlinks to directories
> (except . and ..) are fundamentally impossible in Linux?

Why do you want to be able to do that?  Use symlinks or loopback mounts
and stay out of trouble.

> (I'm thinking about trying to write a garbage collected filesystem
> with hardlinks to directories.)

Sounds like a lot of extra complexity.  Is this academic or do you have
a practical use for it?

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

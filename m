Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129703AbQK3HGU>; Thu, 30 Nov 2000 02:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132520AbQK3HGK>; Thu, 30 Nov 2000 02:06:10 -0500
Received: from janus.hosting4u.net ([209.15.2.37]:46096 "HELO
        janus.hosting4u.net") by vger.kernel.org with SMTP
        id <S129703AbQK3HGG>; Thu, 30 Nov 2000 02:06:06 -0500
Message-ID: <3A25F454.6ECD3205@a2zis.com>
Date: Thu, 30 Nov 2000 07:31:48 +0100
From: Remi Turk <remi@a2zis.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CLONE_NAMESPACE, links for dirs and mount(2) for normal users 
 questions
In-Reply-To: <3A1FFA2C.A8980FD8@a2zis.com> <20001128211327.K8881@wire.cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> [Remi Turk]
> > Do I understand correctly that this means hardlinks to directories
> > (except . and ..) are fundamentally impossible in Linux?
> 
> Why do you want to be able to do that?  Use symlinks or loopback mounts
> and stay out of trouble.

Probably just because I'm crazy ;-)
Of course I could use symlinks or loopback mounts, but it itn't nearly
as much fun as a directory which really contains itself :-)

> > (I'm thinking about trying to write a garbage collected filesystem
> > with hardlinks to directories.)
> 
> Sounds like a lot of extra complexity.  Is this academic or do you have
> a practical use for it?

Acedemic.
Well, I might find some practical use for it some day.

(I got inspired by an old thread about garbage collecting filesystems
without a clear answer about whether it was possible to write one in
Linux
(http://www.uwsg.indiana.edu/hypermail/linux/kernel/0001.1/0410.html)
and the recent thread  "[BUG] Inconsistent behaviour of rmdir")

> 
> Peter

-- 
Linux 2.4.0-test11-ac4 #1 Tue Nov 28 15:51:01 CET 2000
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTENVgw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 17:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbTENVgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 17:36:52 -0400
Received: from chaos.analogic.com ([204.178.40.224]:44161 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262930AbTENVgu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 17:36:50 -0400
Date: Wed, 14 May 2003 17:51:34 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Yoav Weiss <ml-lkml@unpatched.org>
cc: Mike Touloumtzis <miket@bluemug.com>, Ahmed Masud <masud@googgun.com>,
       Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <Pine.LNX.4.44.0305150035230.12748-100000@marcellos.corky.net>
Message-ID: <Pine.LNX.4.53.0305141742260.13000@chaos>
References: <Pine.LNX.4.44.0305150035230.12748-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 May 2003, Yoav Weiss wrote:

> > Not so, with the latest Red Hat distribution (9). You can no longer
> > set init=/bin/bash at the boot prompt.... well you can set it, but
> > then you get an error about killing init. This caused a neighbor
> > a lot of trouble when she accidentally put a blank line in the
> > top of /etc/passwd. Nobody could log-in. I promised to show her
> > how to "break in", but I wasn't able to. I had to take her hard-disk
> > to my house, mount it, and fix the password file. All these "attempts"
> > at so-called security do is make customers pissed.
> >
>
> 1. Insert Live-System CD (Knoppix for example)
> 2. Boot from it.
> 3. Mount rootfs.
> 4. Fix things.
> 5. Remove CD and reboot.
>

Not so easy. Many persons have drivers that must be installed using
initrd (SCSI, Firewire,  etc.) before their root file-systems are
accessible.

This means that there isn't a general-purpose tool that you can
take with you (except another PC, you can use to mount the
locked disk). NotGood(tm). Sun allows their install CD/ROM to
be used for repair. Other vendors did this also. New "security"
out of Red-Hat seems to prevent this, ALF-F2, etc., used to bring
up other virtual terminals. They don't anymore. I think every
OS vendor should be required to spend a few weeks in the field,
preferably in Afghanistan <grin>, before they even consider mucking
with accepted principles.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


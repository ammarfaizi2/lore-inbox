Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTESGJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 02:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbTESGJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 02:09:29 -0400
Received: from ip68-4-255-84.oc.oc.cox.net ([68.4.255.84]:34711 "EHLO
	ip68-101-124-193.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id S262352AbTESGJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 02:09:28 -0400
Date: Sun, 18 May 2003 23:22:24 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Halil Demirezen <nitrium@bilmuh.ege.edu.tr>
Cc: aradorlinux@yahoo.es, linux-kernel@vger.kernel.org
Subject: Re: about buffer overflow.
Message-ID: <20030519062224.GC2411@ip68-101-124-193.oc.oc.cox.net>
References: <20030518222742.GA20916@bilmuh.ege.edu.tr> <20030519011145.11d1c3c1.aradorlinux@yahoo.es> <20030519000047.GA23632@bilmuh.ege.edu.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030519000047.GA23632@bilmuh.ege.edu.tr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 03:00:47AM +0300, Halil Demirezen wrote:
> yes that is interesting, however, what i want to learn, clearly, is
> this patch available from 2.4.20-rc1 at every default linux kernel
> from this moment on?

It (ExecShield0 is *not* in the mainline kernel at this time. I don't
know when (or even if) it'll be added to the mainline kernels either.

Red Hat's Rawhide kernels (2.4.20-1.1990 for example) seem to have it,
but those are experimental kernels that are not for production use. I
guess time will tell whether Red Hat ships ExecShield by default in
their next release.

BTW, another option is the pageexec ("PaX") patch:
http://pageexec.virtualave.net/ (warning: this page has pop-up windows)

and that's integrated into a more comprehensive security patch,
grsecurity:
http://www.grsecurity.net/

-Barry K. Nathan <barryn@pobox.com>

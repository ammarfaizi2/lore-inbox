Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264471AbUEMTkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbUEMTkq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbUEMTjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:39:46 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:10123 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S264496AbUEMTRc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:17:32 -0400
Date: Thu, 13 May 2004 15:17:28 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Chuck Wolber <chuckw@quantumlinux.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Weird cold boot problems with Abit KT7 motherboard
In-Reply-To: <Pine.LNX.4.44.0405121619380.26332-100000@bailey.quantumlinux.com>
Message-ID: <Pine.LNX.4.58.0405131505030.2310@marabou.research.att.com>
References: <Pine.LNX.4.44.0405121619380.26332-100000@bailey.quantumlinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004, Chuck Wolber wrote:

> On Wed, 12 May 2004, Pavel Roskin wrote:
>
> > I have noticed several anomalies with Abit KT7 motherboard.  They all
> > happen after power on.  First reboot from Linux (using the reboot
> > command or reset button) usually fixes all the problems.  Sometimes two
> > or three resets are needed before the motherboard starts working
> > properly.  In two cases (of about 20) the motherboard started working
> > properly right after powering up.
>
> %< SNIP
>
> > I just hope the description below will rings a bell with somebody, and
> > I'll gladly test the suggestions.  If not, the motherboard will go to the
> > dumpster.
>
>
> We just recently saw a similar report with the same motherboard. The
> system apparently boots fine under FC2. This is only second-hand
> information though, I have not personally tested this.

The kernel from Fedora testing (kernel-2.6.5-1.358.i686) indeed passed the
PCI probe on the cold booted machine with the TI PCI1410 bridge inserted
(it would have booted if not missing reiserfs support).  However, I was
unable to reproduce the cold boot problems I described with any kernel
since then.  Everything is working properly today.

I just didn't want to miss a chance to fix support for this motherboard.
But from my today's experience, from the replies I got and from further
search on the web, it appears unlikely that there is anything we can do in
the kernel to work around the cold boot problems with Abit KT7.

Thanks to everybody who replied!

-- 
Regards,
Pavel Roskin

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUC1C6u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 21:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUC1C6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 21:58:49 -0500
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:26755 "EHLO
	albatross.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262003AbUC1C6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 21:58:48 -0500
From: Eric <eric@cisu.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x strangeness with large buffer usage via network transfer/disk and SEGV processes
Date: Sat, 27 Mar 2004 20:58:13 -0600
User-Agent: KMail/1.6.1
References: <000001c41450$4c6c1f30$030aa8c0@PANIC>
In-Reply-To: <000001c41450$4c6c1f30$030aa8c0@PANIC>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403272058.13729.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 March 2004 5:07 pm, Shawn Starr wrote:
> I don't get something maybe someone can explain why this is happening:
>
> 1) When using a large amount of buffers via sending say a 800MB file from
> one PC to another, the Linux system will segfault processes but not preform
> an OOM. Even though the system itself has not touched swap memory. Why is
> the kernel killing/or why are the processes dying with Segfault?
>
> I see this happening when I extract a Linux source tarball and have certain
> processes running, while tar extracts the process will just receive a
> segmentation fault w/o core.
>
> When using a virtual OS emulator, the emulator will just die.
>
> I don't remember this behaviour in 2.4 at all and I don't think this is
> correct. I have PREEMPT enabled as well.
>
> Is this a problem or is this correct behavour?
>
Crashes a correct behavior?
 You must  be used to windows where crashes are sometimes the correct behavior 
hehe.

Sorry, I had to say it. 
Otherwise I don't have a serious answer to your problem ;)

> Thanks
>
> Shawn S.

-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------

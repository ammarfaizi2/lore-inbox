Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267521AbUIJPsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267521AbUIJPsV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 11:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267515AbUIJPqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 11:46:45 -0400
Received: from pengo.systems.pipex.net ([62.241.160.193]:7605 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S267517AbUIJPpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:45:31 -0400
Date: Fri, 10 Sep 2004 16:46:07 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein.homenet
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Latest microcode data from Intel.
In-Reply-To: <4141CAAB.4020708@tmr.com>
Message-ID: <Pine.LNX.4.44.0409101641220.1294-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004, Bill Davidsen wrote:

> Tigran Aivazian wrote:
> > Hello,
> > 
> > I have received and tested the latest microcode data file from Intel, The
> > file is dated 2nd September 2004. You can download it both as standalone
> > (bzip2-ed) text file and bundled with microcode_ctl utility from the
> > Download section of the website:
> > 
> > http://urbanmyth.org/microcode/
> > 
> > Please let me know if you find any problems with this data file or with
> > the Linux microcode driver. Thank you.
> 
> Why are you using /dev/cpu/microcode instead of /dev/cpu/N/microcode for 
> each CPU? Today they are all the same device, but for the future I would 
> think this was an obvious CYA.

I have two questions:

1. What does "CYA" mean?

2. How do you know which device nodes exist on my workstation?

Actually, I am using /dev/cpu/0/microcode as the device node (entry point
into the microcode driver) because that is what is in the distribution I
am running (old Red Hat).

The microcode_ctl utility had a hardcoded default "/dev/cpu/microcode" and 
there is no real reason to change it because different distributions 
prefer a different value, so how to decide who is "right"?

Also, there is no obvious reason why the future has to be in any way
different from the present (or the past :)

Kind regards
Tigran


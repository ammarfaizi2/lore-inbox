Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268922AbUIXQyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268922AbUIXQyU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268916AbUIXQlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:41:52 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:49329 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268944AbUIXQaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:30:46 -0400
Message-ID: <5b64f7f040924093035495d74@mail.gmail.com>
Date: Fri, 24 Sep 2004 12:30:32 -0400
From: Rahul Karnik <deathdruid@gmail.com>
Reply-To: Rahul Karnik <deathdruid@gmail.com>
To: "Johnson, Richard" <rjohnson@analogic.com>
Subject: Re: Migration to linux-2.6.8 from linux-2.4.26
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0409241038250.24372@quark.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.53.0409241038250.24372@quark.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004 11:10:23 -0400 (EDT), Johnson, Richard
<rjohnson@analogic.com> wrote:
> 
> (1) I compiled the new module-init-tools-3.1-pre5.tar.gz. It
> claimed to be backward-compatible. After installing it, it
> complained about something then seg-faulted. Nevertheless
> `insmod` seemed to work so I proceeded.

Error message would be nice to have.
 
> (2) `make oldconfig` didn't work after copying over the
> linux-2.4.26 .config file. This meant that I had to answer
> hundreds of questions.

This is unavoidable; 2.6 has lots and lots of new features.

> (3) `make bzImage` required that I install a new 'C' compiler.
> This took several hours.

gcc 2.95 should work for 2.6, although I have heard some mention on
the list of that not being true anymore.

> (4) Eventually "bzImage" got made. I tried `make modules`.
> This took over 2 hours, went through everything several times.
> This is a 2.8 GHz system. It usually takes about 6 minutes
> to compile the kernel and all the modules. There is something
> very wrong with the new compile method when it takes 120
> times longer to compile than previously.

Something is seriously wrong here, and it has nothing to do with the
"new compile method". Please post your 2.4 and 2.6 config files,
compiler version and platform info.

> (6)  The system would boot, but not find a file-system to mount.

Details?
 
> (7)  Tried to reboot using previous kernel. It failed to
> load the required drivers for my SCSI disks so I have no
> root file-system there.
> 
> (8)  I am currently unable to use my main system. I will have
> mount my main SCSI drive on this system, and replace the
> module-init-tools with the previous modutils. This should
> allow me to get "back" to my previous mounted root.

Related to (1), I assume.

Have you tried using a rescue disk to fix the problem? Knoppix (or a
distro rescue disk) should work fine.

Thanks,
Rahul

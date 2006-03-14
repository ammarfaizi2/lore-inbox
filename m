Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751517AbWCNUuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbWCNUuL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 15:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWCNUuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 15:50:11 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:28750 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751517AbWCNUuI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 15:50:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g8sAC9PUO5kPFar2sBfCsIJDEingHbsMwidXwnTUii8wR9G8FMIei3h8HTvkhRMBHYmF+1ceXN7TSuxXtDzV7/KnnEqHYhfhHaF1oy3By1O1MVm43bFyfVeIdpGgC1mpbojjlJOIO/dO7lQ5O76FfUpZ2+2R5AtflKOGdrLe/K8=
Message-ID: <436c596f0603141250r5b38d88y923ca00ba07a2a5d@mail.gmail.com>
Date: Tue, 14 Mar 2006 17:50:07 -0300
From: "marcos cunha" <jakexblaster@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel config problem between 2.4.x to 2.6.x!
In-Reply-To: <1142300238.13256.80.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436c596f0603121015j2a091ab2sf43d0c5c396bbb72@mail.gmail.com>
	 <7c3341450603121247n7afe018m@mail.gmail.com>
	 <436c596f0603121632qe3151k793fd3ccd9a0eacb@mail.gmail.com>
	 <200603130708.13685.nick@linicks.net>
	 <436c596f0603130342u4d38445bt5e9f129349cda0c8@mail.gmail.com>
	 <1142297572.7090.4.camel@shogun.daga.dyndns.org>
	 <436c596f0603131731w172bb28cr43eec5e5bb32bf25@mail.gmail.com>
	 <1142300238.13256.80.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

eheh.. I dont know about this "Halloween document", I'm not a kernel
developer, just a Linux user, I'm building DISTROS, not PATCHES or
smth for the kernel, since I dont have this exp level on hardware
coding.

Btw, I got a way to run sound on my distro, fixing (one of) my
problem(s). I've rebuilt my kernel with built-in ALSA, and sb16
modules. When I tryed to do modprobe on snd16 or sbawe, it says that
there is no SB16/AWE board. So I installed alsa-lib and alsa-utils
anyways and got, amazing, working. Just a option to disable the ISA
PlugAndPay. So, I cannot work with the ISAPNP? My dmesg's isapnp from
kernel shows "No cards founds", the problem is on my BIOS config or
what?

And about the DSL PPPoE, it was really strange, on the last bzImage
(ALSA), I've included full PPP support as modules. When I did
pppoe-connect, I got TIMED OUT, but at this time, ip route gave me a
ppp0 link to my ISP and changed my default gateway. But neither lynx
nor wget found nothing... try out pinging 200.165.152.155, it's my DNS
unique server. =/

On 3/13/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Mon, 2006-03-13 at 22:31 -0300, j4K3xBl4sT3r wrote:
> > doesnt matter executing the rc.udev, I run udevd and udevstart on my
> > system. and doesnt work =S
>
> Did you read the "post Halloween document" describing changes from 2.4
> to 2.6 or the LWN coverage of the 2.4->2.6 transition?  It's not
> supposed to be a seamless upgrade...
>
> udev must be working if ALSA works as it also depends on device nodes.
>
> IIRC isapnptools is not needed if CONFIG_PNP is enabled.
>
> Lee
>
>

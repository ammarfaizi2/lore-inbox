Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274789AbRJQHzY>; Wed, 17 Oct 2001 03:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274990AbRJQHzO>; Wed, 17 Oct 2001 03:55:14 -0400
Received: from eamail1-out.unisys.com ([192.61.61.99]:9418 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S274789AbRJQHy7>; Wed, 17 Oct 2001 03:54:59 -0400
Message-ID: <DD0DC14935B1D211981A00105A1B28DB033ED3D8@NL-ASD-EXCH-1>
From: "Leeuw van der, Tim" <tim.leeuwvander@nl.unisys.com>
To: "'lkm'" <linux-kernel@vger.kernel.org>
Subject: Re: VM
Date: Wed, 17 Oct 2001 02:55:29 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried more-or-less comparable desktop workloads on various
kernel-versions.

So far my conclusion is that for desktops, the VM in the recent -ac kernels
is worst, the VM in Linus's recent kernels is much better for the desktop,
but that the kernel with the smoothest operation on the desktop is:

2.4.4ac8

(There are several 2.4.4-ac kernels with identical VM just I happen to have
this one installed as a sort of backup)

This is a really old kernel, and I know that there were problems with that
VM version under certain loads. Still, the fact that it performs well is
perhaps an interesting datapoint.
I don't know if problems in the 2.4.4-ac8 VM can be killed without also
killing the performance?

The tested load is:

- Compiling kernel
- Browsing web with Mozilla or Galeon
- Opening Evolution and looking at mail
- Editing files with XEmacs

My criteria were speed of opening new big applications when another big
application is running and compiling at the same time, how useable the
system is while the application starts up, how quickly and smoothly I can
switch from one app. to the other.

All of these are of course highly subjective criteria.

I'm not interested in audio, so I didn't do any tests for smoothness of
playing sound while doing any of these things.

Next weekend I hope to have time to give the VM's another try; this time
I'll apply relevant Rik's patches to the -ac kernel too.

My PC has 64MB of RAM and some slow IDE disks (tuned with DMA and -u 1), and
a 200MHz MMX P1


--Tim


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbUBYOEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 09:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbUBYOEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 09:04:38 -0500
Received: from intra.cyclades.com ([64.186.161.6]:21469 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261330AbUBYOEh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 09:04:37 -0500
Date: Wed, 25 Feb 2004 11:57:32 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: kai.engert@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: only ieee1394 from 2.4.20 works for me
In-Reply-To: <4038BDC3.9030304@kuix.de>
Message-ID: <Pine.LNX.4.58L.0402251153550.21511@logos.cnet>
References: <4038BDC3.9030304@kuix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 Feb 2004, Kai Engert wrote:

> In the last year I have been playing with a variety of combinations of
> ieee1394 controllers, machines, external mass storage devices and linux
> kernel versions. So have some friends of mine.
>
> The only version that works for us is the ieee1394 code that was
> included with kernel version 2.4.20.
>
> (I removed drivers/ieee1394 completely, and replaced it with
> drivers/ieee1394 from 2.4.20)
>
> Using that snapshot, we are able to transfer data to disks and video
> from a camcorder just fine, in all combinations we have tested.
>
> Every other kernel version, both older or newer than 2.4.20, is broken.
> We either see random errors, or writing data to disks stalls
> immediately, or daisy chained devices don't work.
>
> I'm currently using the official Fedora core 1 series kernels, patched
> that way, and it works like a charm.
>
> Please consider to use the 2.4.20 ieee1394 snapshot in future 2.4.x
> releases.

Hi Kai,

As Ben already said, he needs a detailed report of your the problems.

I'm sure he will work to fix them as soon as he has the reports.

Get backtraces with Alt+SysRQ+T and Alt+SysRQ+P when the kernel hangs.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272166AbTHDTuL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 15:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272168AbTHDTuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 15:50:11 -0400
Received: from [209.195.52.120] ([209.195.52.120]:2974 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S272166AbTHDTuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 15:50:07 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Werner Almesberger <werner@almesberger.net>
Cc: "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 4 Aug 2003 12:48:25 -0700 (PDT)
Subject: Re: TOE brain dump
In-Reply-To: <20030804163256.M5798@almesberger.net>
Message-ID: <Pine.LNX.4.44.0308041243500.7534-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003, Werner Almesberger wrote:

> Ihar 'Philips' Filipau wrote:
> >    It makes not that much sense to run kernel (especially Linux) on CPU
> > which is optimized for handling of network packets. (And has actually
> > several co-processors to help in this task).
>
> All you need to do is to make the CPU capable of running the kernel
> (well, some of it), but it doesn't have to be particularly good at
> running anything but the TCP/IP code. And you can still benefit
> from most of the features of NPUs, such as a specialized memory
> architecture, parallel data paths, accelerated operations, etc.

also how many of the standard kernel features could you turn off?
do you really need filesystems for example?
could userspace be eliminated? (if you have some way to give the config
commands to the kernel on the NIC and get the log messages back to the
main kernel what else do you need?)
a lot of the other IO buffer stuff can be trimmed back (as per
config_embedded)

what else could be done to use the kernel features taht are wanted without
bringin extra baggage along?

David Lang

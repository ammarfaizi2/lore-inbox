Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWHPDpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWHPDpb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 23:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWHPDpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 23:45:31 -0400
Received: from post-23.mail.nl.demon.net ([194.159.73.193]:56572 "EHLO
	post-23.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1750893AbWHPDpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 23:45:31 -0400
Message-ID: <44E29546.904@rebelhomicide.demon.nl>
Date: Wed, 16 Aug 2006 05:47:18 +0200
From: "x@rebelhomicide.demon.nl" <x@rebelhomicide.demon.nl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Milton Mobley <miltmobley@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: need source for lspci, lsusb, etc.
References: <af203d350608152014i475899cet53d21e07db42d4a2@mail.gmail.com>
In-Reply-To: <af203d350608152014i475899cet53d21e07db42d4a2@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Milton Mobley wrote:
> Hi, I am building kernels from kernel.org sources, and am having problems
> detecting certain pci and usb devices (I didn't change the kernel code
> much yet).
> Where can I find the sources for programs that live in /sbin, 
> /usr/sbin, etc.,
> especially lspci, lsusb, lsmod?
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
Milton, your distribution of Linux should provide those.
For Debian Linux for example, you'd do:

$ dpkg -S lspci
pciutils: /usr/bin/lspci

..and you note that lspci is in the 'pciutils' package.
You could then do as follows:

$ apt-get update
....
$ apt-get source pciutils

The source would be downloaded and unpacked in the current working 
directory.

Regards, Michiel de Boer

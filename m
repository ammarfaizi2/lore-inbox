Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284189AbRLFUSL>; Thu, 6 Dec 2001 15:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284210AbRLFURy>; Thu, 6 Dec 2001 15:17:54 -0500
Received: from mk-smarthost-1.mail.uk.tiscali.com ([212.74.112.71]:52490 "EHLO
	mk-smarthost-1.mail.uk.tiscali.com") by vger.kernel.org with ESMTP
	id <S284181AbRLFUQ0>; Thu, 6 Dec 2001 15:16:26 -0500
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
X-Comment-To: kees
In-Reply-To: <fa.ljcupnv.1ghotjk@ifi.uio.no>
Subject: Re: Q: device(file) permissions for USB
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: daria.co.uk
Message-ID: <664.3c0fd1b7.a66fa@trespassersw.daria.co.uk>
Date: Thu, 06 Dec 2001 20:14:47 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <fa.ljcupnv.1ghotjk@ifi.uio.no>,
	kees <kees@schoen.nl> writes:
k>   This message is in MIME format.  The first part should be readable text,
k>   while the remaining parts are likely unreadable without MIME-aware tools.
k>   Send mail to mime@docserver.cac.washington.edu for more info.
k> 
k> ---1463801846-915869288-1007668919=:13843
k> Content-Type: TEXT/PLAIN; charset=US-ASCII
k> 
k> Hi,
k> 
k> I have been playing with an USB camera. I've run into the following
k> problem:
k> The (default?) permissions for /proc/bus/usb/001/011 (and others) are
k> 0644. This makes the ioctl (see attached trace to fail). So I have to:
k> either chmod the usb device file each time I unplug and replug the camera
k> OR make the pencam program SUID root, which is neither comfortable.
k> Is there a way to affect the default permissions for the USB devices?

Use hotplug to run a script to change the permissions when the device
is connected. Mail me off list for an example.

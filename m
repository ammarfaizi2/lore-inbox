Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWCZCTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWCZCTT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 21:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWCZCTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 21:19:18 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:16410 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751276AbWCZCTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 21:19:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=R//7aIoAQFgFLKbYqI1zJI6qQ21miLGaQaPqemjJPjfvFCN+u6WCV8oyyKYVHyaeqj6I0ev+MlygfnrWu5a15cUPC4VD0aRQY/WSo8djZW4eIXCMkGcdLHCj8A6DJyMsnprqV6dM9oyWLlKULIlbYKkEUaPpGvRHBN5unj+giH8=
Message-ID: <4425FB22.7040405@gmail.com>
Date: Sun, 26 Mar 2006 09:23:30 +0700
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
Organization: IcySpace.net
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-c-programming@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Virtual Serial Port
References: <442582B8.8040403@gmail.com> <Pine.LNX.4.61.0603251945100.29793@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0603251945100.29793@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=65ABD897
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> You could write a device driver implementing virtual serial ports. Then you 
> just add an ioctl that connects/disconnects virtual ports to real ports if 
> desired.
> I do not quite see what this would be good for, but I am sure it's 
> good for learning or for fun. :)

Hi Jan Engelhardt,

My purpose is to provide serial interfaces for debugging. My real box
acts as remote host connecting to VMWare box by a *virtual* serial cable
so that I can set up a debugging environment.

There are several solutions for this problem but they could only run on
Windows. Eg:
- - http://www.mks.zp.ua/vspdxp.php
- - http://www.virtual-serial-port.com/virtual-serial-port-kit.html

I'll buy an USB-to-Serial cable and a Serial-Serial cable to solve this
problem but it's also interesting for me to write such device driver.
I'll try it later.

Mikado
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEJfshNWc9T2Wr2JcRAhPwAJ9d/eifASrLPvJwOy6A4sSxgzMc0gCcChrG
rSL3gqaTWernckeKhfc+wqY=
=wIb+
-----END PGP SIGNATURE-----

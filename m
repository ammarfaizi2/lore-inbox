Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316404AbSFJVrS>; Mon, 10 Jun 2002 17:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316416AbSFJVrR>; Mon, 10 Jun 2002 17:47:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28687 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316404AbSFJVrQ>;
	Mon, 10 Jun 2002 17:47:16 -0400
Message-ID: <3D051DAF.6020107@mandrakesoft.com>
Date: Mon, 10 Jun 2002 17:44:15 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kai Henningsen <kaih@khms.westfalen.de>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: of ethernet names (was [PATCH] Futex Asynchronous
In-Reply-To: <Pine.LNX.4.44.0206091130490.13751-100000@home.transmeta.com> <8QbwdDPmw-B@khms.westfalen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, networking is moving in the direction described --
yes, as Linus points out, we will need the magic ioctl stuff for back 
compat.
But the main way to communicate with a net device is netlink, already a 
chardev.  ifconfig actually should be updated to use netlink.

	Jeff




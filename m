Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284544AbRLESOg>; Wed, 5 Dec 2001 13:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284543AbRLESO0>; Wed, 5 Dec 2001 13:14:26 -0500
Received: from mail006.mail.bellsouth.net ([205.152.58.26]:23164 "EHLO
	imf06bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S284542AbRLESOV>; Wed, 5 Dec 2001 13:14:21 -0500
Message-ID: <3C0E63F8.8CD0B9CA@mandrakesoft.com>
Date: Wed, 05 Dec 2001 13:14:16 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Todo] Remove usage of (f)suser in kernel
In-Reply-To: <20011205181558.R360@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> After a quick round of grep:ing, I came up with the following files
> needing fixes to substitute usage of (f)suser for proper capabilities:
[...]
> Since I don't know what the maintainers of some of these files want
> as capabilities, I've decided not to fix this myself. zr36120.c is
> only a matter of removing an #ifdef/#else/#endif combo and doing some
> reindenting, though.

We need to kill those in 2.5 I think.  s/suser/capable(...)/ has been on
the kernel janitor's list for a while.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno


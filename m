Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312486AbSDCXfK>; Wed, 3 Apr 2002 18:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312476AbSDCXfB>; Wed, 3 Apr 2002 18:35:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42759 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312279AbSDCXeu>; Wed, 3 Apr 2002 18:34:50 -0500
Subject: Re: [PATCH] 2.4: BOOTPC /proc info.
To: penguin@wombat.ca (Craig)
Date: Thu, 4 Apr 2002 00:51:54 +0100 (BST)
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.42.0204031759090.711-100000@wombat> from "Craig" at Apr 03, 2002 06:09:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16suXi-0004nG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So what do people think?  Should this go in 2.4 or 2.5?
> Is this worthwhile to pursue putting this in (it's very useful to us,
> so we figured others could use it)?
> Should i send this to Linus for 2.5 inclusion as well?

The longer term goal is to remove this stuff from the kernel and push it 
into the initrd support. Instead of kernel hacks you use an initrd that
runs the real bootpc. 

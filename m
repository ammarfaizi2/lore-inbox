Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285256AbRLFW0m>; Thu, 6 Dec 2001 17:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285259AbRLFW0d>; Thu, 6 Dec 2001 17:26:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44562 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285255AbRLFW0R>; Thu, 6 Dec 2001 17:26:17 -0500
Subject: Re: Linux/Pro  -- clusters
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 6 Dec 2001 22:35:12 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112061236050.10877-100000@penguin.transmeta.com> from "Linus Torvalds" at Dec 06, 2001 12:37:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16C76m-0003Kk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 6 Dec 2001, Alan Cox wrote:
> > The internal representation is kdev_t, which wants to turn into a pointer
> 
> No.
> 
> That kdev_t has been around for years, and is going away. In 2.6 there
> will _be_ no kdev_t.
> 
> There is "struct block_device" for internal stuff, and "dev_t" for
> external stuff. The first one is a real structure, the second one is just
> a cookie.

Ok so kdev_t will split into structs for char and block device which are
seperate things ?

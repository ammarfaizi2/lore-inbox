Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285317AbRLFXh0>; Thu, 6 Dec 2001 18:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285315AbRLFXhI>; Thu, 6 Dec 2001 18:37:08 -0500
Received: from mail209.mail.bellsouth.net ([205.152.58.149]:31493 "EHLO
	imf09bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S285311AbRLFXhE>; Thu, 6 Dec 2001 18:37:04 -0500
Message-ID: <3C10011A.A16E5287@mandrakesoft.com>
Date: Thu, 06 Dec 2001 18:36:58 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.13-12mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Tim Hockin <thockin@sun.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arjanv@redhat.com, saw@sw-soft.com, sparker@sparker.net
Subject: Re: [PATCH] eepro100 - need testers
In-Reply-To: <E16C81m-0003Zm-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > This patch was developed here to resolve a number of eepro100 issues we
> > were seeing. I'd like to get people to try this on their eepro100 chips and
> > beat on it for a while.
> 
> Works for me. Its the first eepro100 driver that wont choke eventually on
> my i810 board and its also the only one that will recover the board after
> a soft boot when it had previously started spewing errors

This patch got me thinking about net driver ring sizes in general.  When
you are talking thousands of packets per second at 100 mbit, a larger
ring size than the average 32-64 seems to make sense too.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno


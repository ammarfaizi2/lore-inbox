Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279983AbRKOBmb>; Wed, 14 Nov 2001 20:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279995AbRKOBmK>; Wed, 14 Nov 2001 20:42:10 -0500
Received: from mail315.mail.bellsouth.net ([205.152.58.175]:2243 "EHLO
	imf15bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279983AbRKOBl6>; Wed, 14 Nov 2001 20:41:58 -0500
Message-ID: <3BF31D4E.4D614D5D@mandrakesoft.com>
Date: Wed, 14 Nov 2001 20:41:34 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: harish.vasudeva@amd.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Need Info on Checksum Offloading
In-Reply-To: <CB35231B9D59D311B18600508B0EDF2F0197A311@caexmta9.amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

harish.vasudeva@amd.com wrote:
> 
> Hi All,
> 
>  Could any1 pls direct me wherein i could find some documentation about implementing checksum offloading for my ethernet LAN driver?


There is not good documentation.  Feel free to ask me questions, I am
the Linux network driver maintainer.

First, search the source code in linux/drivers/net/* for
NETIF_F_IP_CSUM, NETIF_F_HW_CSUM, skb->csum, and nr_frags.

Can I expect an ethernet driver submitted to me, soon?

	Jeff

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129781AbRBYCho>; Sat, 24 Feb 2001 21:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129782AbRBYChd>; Sat, 24 Feb 2001 21:37:33 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:59064 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129781AbRBYChR>; Sat, 24 Feb 2001 21:37:17 -0500
Message-ID: <3A986EDB.363639E7@coplanar.net>
Date: Sat, 24 Feb 2001 21:32:59 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: netdev@oss.sgi.com,
        Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New net features for added performance
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

(about optimizing kernel network code for busmastering NIC's)

> Disclaimer:  This is 2.5, repeat, 2.5 material.

Related question: are there any 100Mbit NICs with cpu's onboard?
Something mainstream/affordable?(i.e. not 1G ethernet)
Just recently someone posted asking some technical question about
ARMlinux for and intel card with 2 1G ports, 8 100M ports,
an onboard ARM cpu and 4 other uControllers... seems to me
that ultimately the networking code should go in that direction:
immagine having the *NIC* do most of this... no cache pollution problems...


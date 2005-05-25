Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbVEYNJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVEYNJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 09:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVEYNJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 09:09:58 -0400
Received: from web8509.mail.in.yahoo.com ([202.43.219.171]:50004 "HELO
	web8509.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S262338AbVEYNJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 09:09:22 -0400
Message-ID: <20050525130917.60035.qmail@web8509.mail.in.yahoo.com>
Date: Wed, 25 May 2005 14:09:17 +0100 (BST)
From: Guddu Guddu <guddu_blr123@yahoo.co.in>
Subject: RE: Mounting cramfs from RAM address
To: Mikael Starvik <mikael.starvik@axis.com>, linux-kernel@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mikael for a nice pointer.
I even tried creating a MTD RAM device with a test 
module and I could access the memory. I feel I shall
be able to mount now my cramfs to it.

Thanks again
Guddu

--- Mikael Starvik <mikael.starvik@axis.com> wrote:
> One way is to create a MTD RAM device and mount
> that. Look in 
> arch/cris/drivers/axisflashmap.c for example (search
> for RAM device).
> 
> /Mikael
> 
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On
> Behalf Of Guddu Guddu
> Sent: Wednesday, May 25, 2005 8:08 AM
> To: linux-kernel@vger.kernel.org
> Subject: Mounting cramfs from RAM address
> 
> 
> Hi,
> 
> I want to mount my cramfs stored at a particular
> address in RAM (i.e 0x8100_0000). What is the best
> way
> to do so?
> 
> -- guddu
> 
> 
> 
>
________________________________________________________________________
> Yahoo! India Matrimony: Find your life partner
> online
> Go to: http://yahoo.shaadi.com/india-matrimony
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony

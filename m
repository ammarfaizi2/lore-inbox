Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129878AbQLULgV>; Thu, 21 Dec 2000 06:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129905AbQLULgL>; Thu, 21 Dec 2000 06:36:11 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:50160 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129878AbQLULgD>; Thu, 21 Dec 2000 06:36:03 -0500
Message-ID: <3A41E522.B6C65F21@uow.edu.au>
Date: Thu, 21 Dec 2000 22:10:26 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swap write clustering
In-Reply-To: <Pine.LNX.4.21.0012210255001.1736-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> Hi,
> 
> Basically this new swap_writepage function looks for dirty swapcache pages
> which may be contiguous (reverse and forward searching wrt to the physical
> address of the page being passed to swap_writepage) and builds a page list
> which is written "at once".
> 
> The patch is against test13pre3.
> 
> Comments are welcome. (especially about the __find_page_nolock
> modification)
> 

Have you any benchmarks for this?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289034AbSANUom>; Mon, 14 Jan 2002 15:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289021AbSANUo0>; Mon, 14 Jan 2002 15:44:26 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:11146 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S289044AbSANUny>; Mon, 14 Jan 2002 15:43:54 -0500
Message-ID: <3C43445D.24D5415F@nortelnetworks.com>
Date: Mon, 14 Jan 2002 15:49:33 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
Cc: David Lang <david.lang@digitalinsight.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, babydr@baby-dragons.com,
        linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <Pine.GSO.4.21.0201141452520.224-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Mon, 14 Jan 2002, David Lang wrote:
> 
> > doesn't matter, they are likly to be found on dedicated servers where
> > the flexibility of modules is not needed and the slight performance
> > advantage is desired.
> >
> > making everything modular is fine for desktops/laptops but why should
> > dedicated servers pay the price?
> 
> There should be no price.  And AFAICS that's doable.

I haven't been following the initramfs stuff, but now I have a question. 
Currently we're using initrd to store a kernel and compressed ramdisk bundled
together as an ~7MB single file that gets netbooted by firmware in a card.  Will
it be possible to bundle initramfs together with the kernel into a single file
in this same manner?

Thanks,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

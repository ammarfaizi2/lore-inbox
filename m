Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRBTQxI>; Tue, 20 Feb 2001 11:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRBTQw6>; Tue, 20 Feb 2001 11:52:58 -0500
Received: from kxmail.berlin.de ([195.243.105.30]:21894 "EHLO kxmail.berlin.de")
	by vger.kernel.org with ESMTP id <S129115AbRBTQwq>;
	Tue, 20 Feb 2001 11:52:46 -0500
Message-ID: <3A92A071.8D7906C8@berlin.de>
Date: Tue, 20 Feb 2001 17:50:57 +0100
From: Norbert Roos <n.roos@berlin.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Probs with PCI bus master DMA to user space
In-Reply-To: <Pine.LNX.3.96.1010220084656.23246Q-100000@mandrakesoft.mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> On Tue, 20 Feb 2001, Norbert Roos wrote:
> 
> > Jeff Garzik wrote:
> >
> > > > But the buffers are usually allocated with malloc() by any application
> > > > which wants to use my driver.. otherwise my driver would have to offer a

> 
> fd = open(...);
> buf = mmap(fd, ...);
> fill_buffer_with_data(buf);
> ioctl(fd, ...); /* tell kernel data is there */
> 

Hm hm - this is exactly what i wanted to avoid: The application should
not
be modified only to be able to use my driver - and if it is using
malloc(), it would have to be modified..

Thanks anyway!

Norbert

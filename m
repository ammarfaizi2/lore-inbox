Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129230AbRBTONZ>; Tue, 20 Feb 2001 09:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129361AbRBTONP>; Tue, 20 Feb 2001 09:13:15 -0500
Received: from kxmail.berlin.de ([195.243.105.30]:14216 "EHLO kxmail.berlin.de")
	by vger.kernel.org with ESMTP id <S129230AbRBTONA>;
	Tue, 20 Feb 2001 09:13:00 -0500
Message-ID: <3A927AE9.CE3B88F9@berlin.de>
Date: Tue, 20 Feb 2001 15:10:49 +0100
From: Norbert Roos <n.roos@berlin.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Probs with PCI bus master DMA to user space
In-Reply-To: <Pine.LNX.3.96.1010220073651.23246O-100000@mandrakesoft.mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> > But the buffers are usually allocated with malloc() by any application
> > which wants to use my driver.. otherwise my driver would have to offer a
> > malloc-like function, but I can hardly force the application to use my
> > own malloc function.
> 
> If you are writing the driver, sure you can.

??

The application is doing something like

  fd = open("/dev/mydriver");
  buf = malloc();
  fill_buffer_with_data(buf);
 write(fd,buf);

And now i should tell the programmer not to use malloc() but my special
driver-malloc?
Or do you mean something different?

Norbert

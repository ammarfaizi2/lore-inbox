Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316991AbSEWTYw>; Thu, 23 May 2002 15:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316992AbSEWTYv>; Thu, 23 May 2002 15:24:51 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:27049 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S316991AbSEWTYu>; Thu, 23 May 2002 15:24:50 -0400
Message-ID: <3CED41D9.30008@wanadoo.fr>
Date: Thu, 23 May 2002 21:24:09 +0200
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-usb-users@lists.sourceforge.net
Subject: Re: What to do with all of the USB UHCI drivers in the kernel?
In-Reply-To: <20020520223132.GC25541@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
 >   From now until July 1, I want everyone to test out both the uhci-hcd
 >   and usb-uhci-hcd drivers on just about every piece of hardware they
 >   can find.  This includes SMP, UP, preempt kernels, big and little
 >   endian machines, and loads of different types of USB devices.

2.5.17, USB onboard Abit BE6, modem ADSL Speedtouch USB :

1) uhci without loading the modem driver :
# modprobe uhci
# rmmod uhci
OOPS (not logged)
kernel: kmem_cache_destroy: Can't free all objects cff416f8
kernel: uhci: not all urb_priv's were freed

2) usb-uhci uhci-hcd usb-uhci-hcd produce no visible difference in the
operation of the modem (62 kbytes/s for 608 kbits/s connexion speed).


Pierre
-- 
------------------------------------------------
   Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------



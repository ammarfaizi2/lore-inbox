Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312426AbSDNTNw>; Sun, 14 Apr 2002 15:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312427AbSDNTNv>; Sun, 14 Apr 2002 15:13:51 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:57960 "EHLO
	server0011.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S312426AbSDNTNu>; Sun, 14 Apr 2002 15:13:50 -0400
Date: Sun, 14 Apr 2002 20:21:13 +0100
From: Ian Molton <spyro@armlinux.org>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: usb-uhci *BUG*
Message-Id: <20020414202113.12136578.spyro@armlinux.org>
In-Reply-To: <3CB9D20C.30000@wanadoo.fr>
Reply-To: spyro@armlinux.org
Organization: The dragon roost
X-Mailer: Sylpheed version 0.7.4cvs5 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet Awoke this dragon, who will now respond:

> 
>  The oops doesn't come when the driver is exiting in this case (as the 
>  patch was for), it "occurs randomly". The problem might be with the usb 
>  hardware.

>  > Ian Molton wrote:
>  >>>What were you doing when the BUG() call happened?
>  >> 
>  >> surfin' the net ;) it appears to occur randomly - its been fine the
>  >> whole day today, although less stressed than yesterday.
> 
>  What is the motherboard, is it an usb add-on card ?

Its a VIA based board, and it /is/ an add-on card. its a 4 port OPTi based
card.

Mobo stuff:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT82C597 [Apollo VP3] (rev 4).
      Master Capable.  Latency=16.  
      Prefetchable 32 bit memory at 0xe0000000 [0xe07fffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x
AGP] (rev 0).      Master Capable.  No bursts.  Min Gnt=4.

USB controller:
  Bus  0, device  10, function  0:
    USB Controller: OPTi Inc. 82C861 (rev 32).
      IRQ 10.
      Master Capable.  Latency=16.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xe0800000 [0xe0800fff].
  Bus  0, device  10, function  1:
    USB Controller: OPTi Inc. 82C861 (#2) (rev 32).
      IRQ 12.
      Master Capable.  Latency=16.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xe0801000 [0xe0801fff].

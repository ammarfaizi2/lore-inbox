Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279030AbRJ2Fnr>; Mon, 29 Oct 2001 00:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279023AbRJ2Fnh>; Mon, 29 Oct 2001 00:43:37 -0500
Received: from dispatch.lakeheadu.ca ([216.211.0.8]:28690 "HELO
	dispatch.lakeheadu.ca") by vger.kernel.org with SMTP
	id <S279022AbRJ2Fna>; Mon, 29 Oct 2001 00:43:30 -0500
Message-ID: <3BDCE9FA.7040101@mail.myrealbox.com>
Date: Mon, 29 Oct 2001 00:32:42 -0500
From: "Daniel R. Warner" <drwarner@mail.myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.5) Gecko/20011019
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 8139too on ABIT BP6 causes "eth0: transmit timed out"
In-Reply-To: <16095.1004308212@nice.ram.loc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raphael Manfredi wrote:

> Specifically, I get:
> 
>  NETDEV WATCHDOG: eth0: transmit timed out
>  eth0: Tx queue start entry 32190531  dirty entry 32190527.
>  eth0:  Tx descriptor 0 is 00002000.
>  eth0:  Tx descriptor 1 is 00002000.
>  eth0:  Tx descriptor 2 is 00002000.
>  eth0:  Tx descriptor 3 is 00002000. (queue head)
>  eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
> 
> and then the machine is dead, network-wise.  I have to reboot (reset).

I have this problem when I compile the driver with PIO mode, except it 
is that way as soon as the card is initalized. The only way for me to 
use PIO is to put the Becker driver in its place.

-D



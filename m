Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263473AbRFFEaZ>; Wed, 6 Jun 2001 00:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263354AbRFFEaQ>; Wed, 6 Jun 2001 00:30:16 -0400
Received: from [208.48.139.185] ([208.48.139.185]:38072 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S263479AbRFFEaH>; Wed, 6 Jun 2001 00:30:07 -0400
Date: Tue, 5 Jun 2001 21:30:01 -0700
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Network Performance Testing Summary
Message-ID: <20010605213001.A13200@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <F120XA946xFRFtReq5G0000dddd@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <F120XA946xFRFtReq5G0000dddd@hotmail.com>; from jw2357@hotmail.com on Wed, Jun 06, 2001 at 02:52:03AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 02:52:03AM +0000, John William wrote:
> 
> The curse of the HP Vectra XU 5/90 strikes again!
> 
> What is interesting is that I tried the NetGear FA310, FA311, 3COM 3cSOHO 
> and 3C905C-TX cards and both the receive and transmit speeds (measured with 
> both iperf and netperf) were so close to each other as to be a non-issue.
> 
> Several people e-mailed me to let me know that "card 'X' performance is 
> terrible, I can only get good performance with card 'Y'". So, I just thought 
> I should send this message out to set things a bit straight.

Did you monitor CPU usage during these tests?

I did some throughput comparing a DLink RTL8139 based card to a 3C905C-TX card on a K6-2 450.  
Both managed to fully saturate 100Mbps.  However, the DLink used up ~90% CPU, and the 3Com 
only used about 50% CPU.  This was on 2.4.5, with the 8139too driver from 2.4.3.

-Dave

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131443AbRCPX4g>; Fri, 16 Mar 2001 18:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131447AbRCPX40>; Fri, 16 Mar 2001 18:56:26 -0500
Received: from 24dyn111.com21.casema.net ([213.17.94.111]:6670 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S131443AbRCPX4Q>;
	Fri, 16 Mar 2001 18:56:16 -0500
Date: Sat, 17 Mar 2001 00:54:39 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.2 network performances
Message-ID: <20010317005439.A7670@home.ds9a.nl>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3AB08FAC.657784CA@qosmos.net> <Pine.LNX.4.33.0103151540240.856-100000@nalle.netsonic.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <Pine.LNX.4.33.0103151540240.856-100000@nalle.netsonic.fi>; from sampsa@netsonic.fi on Thu, Mar 15, 2001 at 03:42:37PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2001 at 03:42:37PM +0200, Sampsa Ranta wrote:

> Yesterday I discovered that the load I can throw out to network seems to
> depend on other activities running on machine. I was able to get
> throughput of 33M/s with ATM when machine was idle, while I compiled
> kernel at same time, the throughput was 135M/s.
> 
> So, I suggest you try to compile kernel while running your UDP stream!

Try raising HZ. Perhaps your driver depends on it. It shouldn't, but who
knows.

Regards,

bert

-- 
http://www.PowerDNS.com      Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136523AbREDVlD>; Fri, 4 May 2001 17:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136524AbREDVky>; Fri, 4 May 2001 17:40:54 -0400
Received: from 20dyn25.com21.casema.net ([213.17.90.25]:61194 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S136523AbREDVkn>;
	Fri, 4 May 2001 17:40:43 -0400
Date: Fri, 4 May 2001 23:40:37 +0200
From: bert hubert <ahu@ds9a.nl>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Sending packets from within the kernel
Message-ID: <20010504234037.A31430@home.ds9a.nl>
Mail-Followup-To: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.31.0105041356080.13540-100000@uranus.terran>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <Pine.LNX.4.31.0105041356080.13540-100000@uranus.terran>; from bp@terran.org on Fri, May 04, 2001 at 02:09:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2001 at 02:09:16PM -0700, bp@terran.org wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> I am working on an kernel module which forwards TCP segments from one
> interface to another (basic routing, no proxy or listener socket), but
> which needs to be able to generate some segments completely independently
> of the client<-->server data stream.  For example, when receiving a SYN
> segment from the client, I want the module to be able to respond itself
> with a SYN+ACK on behalf of the server (and drop the SYN).

The iptables MIRROR target does some stuff you might be able to use.

-- 
http://www.PowerDNS.com      Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet

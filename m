Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286913AbRL1OXI>; Fri, 28 Dec 2001 09:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286916AbRL1OW6>; Fri, 28 Dec 2001 09:22:58 -0500
Received: from firewall.ill.fr ([193.49.43.1]:22239 "HELO out.esrf.fr")
	by vger.kernel.org with SMTP id <S286913AbRL1OWr>;
	Fri, 28 Dec 2001 09:22:47 -0500
Date: Fri, 28 Dec 2001 15:22:28 +0100
From: Samuel Maftoul <maftoul@esrf.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs + ipv6 hanging???
Message-ID: <20011228152228.A928@pcmaftoul.esrf.fr>
In-Reply-To: <3C2BCAED.2030908@nothing-on.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C2BCAED.2030908@nothing-on.tv>; from tmh@nothing-on.tv on Fri, Dec 28, 2001 at 01:29:17AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 01:29:17AM +0000, Tony Hoyle wrote:
> Kernel 2.4.17, gcc-2.95.4, mount 2.11n
> 
> nfs clients seem to hang when ipv6 is on the machine.  No idea why...
> the mount process gets stuck in 'D' state and the only way out is to
> reboot.
> 
> If I remove ipv6 from the box & perform exactly the same operations then 
> it works perfectly.  The mount is definately using the ipv4 address (I 
> don't think the portmapper/nfsd is ipv6 enabled anyway).
Not really sure about this: 
I'm at work using SuSE 7.2 wich is shipped with a native IpV6 support
and our nfs client / server works almost perfectly ( with low testing on
gigabit ethernet machines I've got 26 MB/sec)
        Sam
> 
> Tony

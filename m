Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288921AbSBRX0f>; Mon, 18 Feb 2002 18:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288923AbSBRX0Z>; Mon, 18 Feb 2002 18:26:25 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:55987 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S288921AbSBRX0P>; Mon, 18 Feb 2002 18:26:15 -0500
Date: Tue, 19 Feb 2002 00:26:14 +0100
From: bert hubert <ahu@ds9a.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: jiffies rollover, uptime etc.
Message-ID: <20020219002614.A27210@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <3C717DEA.7090309@candelatech.com> <E16cwUx-00073d-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16cwUx-00073d-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Feb 18, 2002 at 10:31:34PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2002 at 10:31:34PM +0000, Alan Cox wrote:
> > I wonder, is it more expensive to write all drivers to handle the
> > wraps than to take the long long increment hit?  The increment is
> 
> Total cost of handling it right - 0 clocks. Its simply about maths order
> and sign 

$ uname -a ; uptime
Linux newyork-1 2.2.18 #3 Mon Dec 11 15:57:33 EST 2000 i686 unknown
  6:22pm  up 425 days,  1:35,  3 users,  load average: 0.10, 0.05, 0.01

This server is pretty remote and hard to reach, and not sure to reboot
properly unattended - are there predictions about how well 2.2.18 will
survive jiffy wraparound?

Would you consider it worth rebooting for? By the way, this is our second
most important production server, I'm exceedingly pleased with the
stability. We've abused it no end.

Thanks.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
Linux Advanced Routing & Traffic Control: http://ds9a.nl/lartc

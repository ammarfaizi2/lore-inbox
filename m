Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129248AbQLCWej>; Sun, 3 Dec 2000 17:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbQLCWea>; Sun, 3 Dec 2000 17:34:30 -0500
Received: from rsn-rby-gw.hk-r.se ([194.47.128.222]:38097 "EHLO
	tux.rsn.hk-r.se") by vger.kernel.org with ESMTP id <S129248AbQLCWeR>;
	Sun, 3 Dec 2000 17:34:17 -0500
Date: Sun, 3 Dec 2000 23:01:41 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Taco IJsselmuiden <taco@wep.tudelft.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: ip_nat_ftp and different ports
In-Reply-To: <Pine.LNX.4.21.0012032004390.13059-100000@hewpac.taco.dhs.org>
Message-ID: <Pine.LNX.4.21.0012032259320.14309-100000@tux.rsn.hk-r.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2000, Taco IJsselmuiden wrote:

> Hi,
> 
> I'm having trouble masquerading ftp-ports other than 20/21.
> For some service i'm using, i need to masquerade port 42,43,62,63 for FTP
> (I know it's weird...).
> Now, when using 2.2.x kernels i could use
> 'insmod ip_masq_ftp ports=21,41,42,62,63'
> but using 2.4.0-testx the 'ports=' parameter doesn't seem to work for
> ip_nat_ftp.
> Is there any other param I should use (couldn't find it in the docs ;(( )

There is a ftp-multi patch that you can apply to get this working

download iptables-1.2 and run 'make patch-o-matic' and apply the ftp-multi
patch and recompile the ftp module... you're done.

/Martin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

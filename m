Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280448AbRKSXTk>; Mon, 19 Nov 2001 18:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280751AbRKSXTa>; Mon, 19 Nov 2001 18:19:30 -0500
Received: from stephenc.theiqgroup.com ([216.81.249.18]:47761 "EHLO
	owns.warpcore.org") by vger.kernel.org with ESMTP
	id <S280448AbRKSXTQ>; Mon, 19 Nov 2001 18:19:16 -0500
Date: Mon, 19 Nov 2001 17:19:12 -0600
From: Stephen Clouse <stephenc@theiqgroup.com>
To: Alex Buell <alex.buell@tahallah.demon.co.uk>
Cc: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 3Com 3c905c invalid checksum?
Message-ID: <20011119171912.B4048@owns.warpcore.org>
Mail-Followup-To: Alex Buell <alex.buell@tahallah.demon.co.uk>,
	Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0111192234340.9417-100000@tahallah.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline; filename="msg.pgp"
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111192234340.9417-100000@tahallah.demon.co.uk>; from alex.buell@tahallah.demon.co.uk on Mon, Nov 19, 2001 at 10:37:45PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, Nov 19, 2001 at 10:37:45PM +0000, Alex Buell wrote:
> The network card in the docking station I plug my Inspirion 8100 in, is a
> 3Com 3c905C Tornado but apparently at boot time when it is identified, it
> prints "***INVALID CHECKSUM 00e0**. I can't ping other boxes on the
> network, nor can I ping other boxes from the laptop. I've double checked
> and triple checked, and the configuration is indeed correct.
> 
> What does the error message INVALID CHECKSUM means?

The driver predates the 905c, which means you're probably running an older 
kernel.  Get the latest 2.4 kernel, or optionally, just the latest 3c90x driver:

http://www.scyld.com/network/vortex.html

- -- 
Stephen Clouse <stephenc@theiqgroup.com>
Senior Programmer, IQ Coordinator Project Lead
The IQ Group, Inc. <http://www.theiqgroup.com/>

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8

iQA/AwUBO/mTbwOGqGs0PadnEQLSJwCeIdfNKkVNf7FAyr/RwxX/SoyzBIkAnRcE
rhsTW7A5ZCHSQxl4tuVNRg2m
=DKSy
-----END PGP SIGNATURE-----

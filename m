Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbUC2JYH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 04:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbUC2JYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 04:24:07 -0500
Received: from tarantel.rz.fh-muenchen.de ([129.187.244.239]:64461 "HELO
	mailserv.rz.fh-muenchen.de") by vger.kernel.org with SMTP
	id S262773AbUC2JYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 04:24:04 -0500
Date: Mon, 29 Mar 2004 11:24:02 +0200
From: Daniel Egger <degger@tarantel.rz.fh-muenchen.de>
To: Bernd Fuhrmann <silverbanana@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usage of RealTek 8169 crashes my Linux system
Message-ID: <20040329112402.A26390@tarantel.rz.fh-muenchen.de>
References: <40673495.3050500@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2us
In-Reply-To: <40673495.3050500@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 10:24:53PM +0200, Bernd Fuhrmann wrote:

> I'm using a RealTek 8169 1000MBit NIC. However, whenever larger amounts 
> of data are being transfered (copying files through smb for instance) 
> Linux crashes. It happens after 10MB-100MB transferred data so it's 
> never as stable as it should be. The whole System runs fine as long as 
> that Realtek 8169 NIC is not used (by transferring data through it). 
> When it crashes there is no entry for that event in kern.log and the 
> system just hangs.

> I'm using:
> Linux 2.6.4
> gcc 3.3.3
> 2X Athlon MP 2600 Mhz
> Tyan Tiger S2466N-4M Dual / AMD760MPX
> 2x 512MB ECC/REG Infineon DDR PC266 RAM
> Debian (unstable)

Might be a SMP related problem. Since the r8169 fix in 2.6.4 those 
cheapass cards work fine for me albeit a bit slow using the same compiler 
and the same kernel on UP.

--
Servus,
       Daniel


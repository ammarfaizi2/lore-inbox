Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262898AbTCVRN6>; Sat, 22 Mar 2003 12:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263380AbTCVRN6>; Sat, 22 Mar 2003 12:13:58 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:49793 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S262898AbTCVRN5>;
	Sat, 22 Mar 2003 12:13:57 -0500
Date: Sat, 22 Mar 2003 18:24:53 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE todo list
Message-ID: <20030322172453.GB9889@vana.vc.cvut.cz>
References: <1048352492.9219.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048352492.9219.4.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 05:01:32PM +0000, Alan Cox wrote:
> (Minus some stuff which is NDA'd because it involves unreleased chips
> etc)
> 
> -	Audit Promise drivers
> -	BIOS timing stuff

Hi,
  any hope that promise 20265 driver could detect non-udma66 cable
and run at udma2 only? BIOS properly detect this, but Linux driver
wants to use udma100, and usually dies hard with CRC errors during
reading of PTBL extended chain (it also should not lockup when
CRC error happens 5 times in a row, but ...).
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz

						

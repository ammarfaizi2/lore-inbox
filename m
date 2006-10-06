Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWJFIbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWJFIbe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 04:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWJFIbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 04:31:34 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:55982 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751343AbWJFIbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 04:31:33 -0400
Date: Fri, 6 Oct 2006 10:36:20 +0200
From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
To: linux-kernel@vger.kernel.org
Subject: usb resets [Was Re: Merge window closed: v2.6.19-rc1]
Message-ID: <20061006083613.GA5658@cepheus.pub>
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <200610051141.50018.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610051141.50018.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.11+cvs20060403
Organization: Universitaet Freiburg, Institut f. Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Gene Heskett wrote:
> But once my usual .config was achieved, it back to business as 
> usual, complete with my logs being littered with this message:
> 
> Oct  5 11:14:40 coyote kernel: usb 3-2.1: reset low speed USB device using 
> ohci_hcd and address 3
> 
> This is my only (so far) minor nit to pick.
> 
> [root@coyote linux-2.6.19-rc1]# lsusb
> [...]
> Bus 003 Device 003: ID 045e:008c Microsoft Corp.
> [...]

I saw that, too.  But I have

        zeisberg@cepheus:~$ lsusb
        Bus 001 Device 002: ID 046d:c00b Logitech, Inc. MouseMan Wheel
	Bus 001 Device 001: ID 0000:0000  
	Bus 004 Device 001: ID 0000:0000  
	Bus 003 Device 001: ID 0000:0000  
	Bus 002 Device 001: ID 0000:0000  

And whenever the reset occured, my keyboard produced mulitple key events
when a key was pressed.

And since I didn't connect my usb cardreader anymore, the problem
disapeared.  (Yes, it is not listed above.  I'll try to find the time to
do some further testing.)

> This started at about the same time I jumped from a 2.6.16-something to the 
> 2nd rc of 2.6.18
Same for me.  (But at the same time I upgraded my machine from a Duron 600
to a Pentium D 940.  So I thought it has to do with that.)

Best regards
Uwe

-- 
Uwe Zeisberger

$ dc -e "5735816763073014741799356604682P"


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267199AbTAFW6q>; Mon, 6 Jan 2003 17:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267206AbTAFW6q>; Mon, 6 Jan 2003 17:58:46 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12934
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267199AbTAFW6p>; Mon, 6 Jan 2003 17:58:45 -0500
Subject: Re: windows=stable, linux=5 reboots/50 min
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kaleb Pederson <kibab@icehouse.net>
Cc: Lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <LDEEIFJOHNKAPECELHOAKEJFCCAA.kibab@icehouse.net>
References: <LDEEIFJOHNKAPECELHOAKEJFCCAA.kibab@icehouse.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041897120.18831.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 06 Jan 2003 23:52:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-07 at 06:57, Kaleb Pederson wrote:
> I don't get any messages is /var/log/... nor do I get an oops.  I have tried
> this under 2.4.19, 2.4.20, and 2.4.21-pre2 (all compiled with gcc-2.95.3)
> and I get the same behavior.  I have noticed no similarities between the
> crashes.  At this point, I have no idea how to isolate it other than to
> start removing every single unnecessary kernel module/option from my .config
> and recompiling.  Any suggestions?  Want to see a grep of my .config?

Start with the easy bits. Check the CPU fans, run memtest86, reseat all the cards
In some situations Linux will stress the hardware differently to windows - 
especially the RAM. Also if your windows test wasnt SMP its not going to have
tested much.



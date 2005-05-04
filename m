Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVEDAcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVEDAcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 20:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVEDAcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 20:32:52 -0400
Received: from omr3.netsolmail.com ([216.168.230.164]:24571 "EHLO
	omr3.netsolmail.com") by vger.kernel.org with ESMTP id S261951AbVEDAcq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 20:32:46 -0400
Message-ID: <42781848.6080309@verizon.net>
Date: Tue, 03 May 2005 20:33:12 -0400
From: Vincent van de Camp <vncnt@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.7) Gecko/20050418
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.x] Asus K8S-MX very unstable with Linux
References: <20050503181433.17423.qmail@web88004.mail.re2.yahoo.com>
In-Reply-To: <20050503181433.17423.qmail@web88004.mail.re2.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had this board for a couple of months now. The only problem I have
is that the onboard NIC doesn't work with the sis900 module. And then
there's some messages in dmesg that have so far not caused me any problems:

SIS_IDE: probe of 0000:00:02.5 failed with error -1

Losing some ticks... checking if CPU frequency changed.

With some kernels (I'm sure about the one that came with ubuntu, but
also with at least one other x86_64 distribution) dhcpcd didn't work
with the tulip card that's in there now.

I've never had panics though. I'm running vanilla and gentoo 2.6.11 and
12-rc3 sources on this board.

Vincent

Shawn Starr wrote:

>Anyone have this board? I'm about to try 2.6.12-rc3 on
>it to see if DMA works (if not there is fix on
>kerneltrap), if the onboard NIC works, If the onboard
>SATA controller is detected or not.
>
>It's a very new board and I'm experiencing serious
>failures (3 different kernel panics from a RHEL4
>kernel alone). 
>
>I'm curious to know if anyone else has had problems
>with this board.
>
>Thanks, 
>
>Shawn.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753237AbWKCPK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbWKCPK2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 10:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbWKCPK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 10:10:28 -0500
Received: from web38409.mail.mud.yahoo.com ([209.191.125.40]:19126 "HELO
	web38409.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1753237AbWKCPK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 10:10:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=l6/ipDZdBK+lHfz6dBuVdTEVWF8OPskRjr+GVMAHcN7Gj9hRAoHKBu7LScKqsxvjKX8k8IUyQMbhMfP37WODZGyMSnRPNZ/YCBwsfbSUiVXGXduee51LrOTtDtp31RdP0Ak6AAh6P1ZwAGeOuIGCZI9BGj2KWrjTUyDemiTxqFM=  ;
Message-ID: <20061103151026.28031.qmail@web38409.mail.mud.yahoo.com>
Date: Fri, 3 Nov 2006 07:10:26 -0800 (PST)
From: xp newbie <xp_newbie@yahoo.com>
Subject: Re: irqpoll kernel option hurts performance?
To: linux-kernel@vger.kernel.org
In-Reply-To: <1162554724.12810.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> irqpoll has a small impact, how big depends what the
> box does (on a
> gigabit network firewall its bad news, on a typical
> desktop its not
> measurable).

Thank you, Alan. Indeed, it is a desktop machine so I
guess I should not be too concerned. I should note
hoever that while downloading an ISO image from the
Internet and doing nothing else (not even moving the
mouse), the System Monitor showed CPU usage of 15%.
The same machine booting to Windows 2000, shows in
such circumstances 0% CPU use (something lesser than
1% to be more exact).

> IRQ problems of the form you report can arise from a
> couple of places -
> one is vendors getting IRQ routing tables wrong
> (suprisingly common),
> the other may be a Linux bug.
> 

I first heard of that IRQ table misrouting when I
tried to install Ubuntu on an older ASUS motherboard
(P2B-S) and the Ubuntu installer would simply exit
with an error message, saying that the P2B-S is
blacklisted due to its incorrect routing table.

But that board, again, was running Windows 2000
without any performance sacrifices... How does Windows
achieve that trick?

Is it possible that it is only a question of well
tweaked device drivers?

> Checking for a BIOS update may therefore be useful. 

I have it updated to the latest & greatest (still, it
is a year old motherboard).

> Is this a VIA chipset machine ?

Funny that you ask, since after having nightmarish
experience with VIA chipsets on various Windows
machines, I vowed to never buy again any motherboard
that has a VIA chipset. So, the two particular ASUS
motherboards that I mentioned above are not VIA-based.
The motherboard for which I posted the original
message is an ASUS P4P800-E Deluxe (P4 3GHz, 1GB RAM,
nVidia chipset, Promise FastTrack 387 P-ATA
controller).

In fact, searching and researching for a solution to
my problem, I discovered that no one was able to
install Linux on this motherboard without a problem or
needing to compromise on performance. The most common
solution was to instruct the BIOS to use the FastTrack
387 P-ATA controller in "compatible mode" rather than
the "enhanced mode" that works so well in W2K. Here is
a posting related to the subject: 

http://ubuntuforums.org/showthread.php?t=289523

And if you notice, it seems that other users are not
aware of the implications of various "tricks" they use
to make Linux install.

I know that there is an issue with Promise
controllers, as Promise releases only binaries of its
drivers for Linux, not the source code. :(

I was thinking however that among the wonderful talent
in this newsgroup, perhaps I could find a *good*
workaround for this problem. By "good workaround" I
mean "that does not hurt performance".

Thank you so much!
Alex


 
____________________________________________________________________________________
Everyone is raving about the all-new Yahoo! Mail 
(http://advision.webevents.yahoo.com/mailbeta/)


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131376AbRDMOzc>; Fri, 13 Apr 2001 10:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131382AbRDMOzW>; Fri, 13 Apr 2001 10:55:22 -0400
Received: from dyn7d0.dhcp.lancs.ac.uk ([148.88.247.208]:14852 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131376AbRDMOzG>; Fri, 13 Apr 2001 10:55:06 -0400
Date: Fri, 13 Apr 2001 15:53:55 +0000 (GMT)
From: Stephen Torri <s.torri@lancaster.ac.uk>
X-X-Sender: <torri@localhost.localdomain>
To: Arjan van de Ven <arjan@fenrus.demon.nl>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.3-ac3 XIRCOM_CB only working as module
In-Reply-To: <m14neyS-000Od1C@amadeus.home.nl>
Message-ID: <Pine.LNX.4.33.0104131549340.4233-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have built this as a module due to the RedHat system I use (to be
consistent). I found that the xircom_cb driver works fine as a module
except for when using dhcp for dynamic ip address. If I set the ip address
of the network card to a static ip number it work fine. Yet if I choose to
use the dhcp to get my ip address packets leave, as seen via tcpdump, but
it doesn't get an address. I watched tcpdump at the dhcp server and saw
the packets come in from the laptop and the responses go out. The laptop
either is ignoring the message coming from the dhcp server or some other
bizarre reason.

I cannot say if I noticed anything about the yenta_socket driver. If I
could get dhcp to work fine I would be willing to give it a go.

Stephen
s.torri@lancaster.ac.uk

On Thu, 12 Apr 2001, Arjan van de Ven wrote:

> In article <3ACC6425.CBF6BCC4@oracle.com> you wrote:
> > It looks like the new xircom_cb driver only works as module - if built
> >  in kernel there is no sign of eth0 setup.
>
> I haven't tried this; I'll look into this once I get back to work (eg where
> my cardbus machine is). I would not be surprised if it
> turns out to be of the "yenta_socket is not initialized yet, so the card is
> invisible at pci scan time" type....
>
> Greetings,
>    Arjan van de Ven
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
-----------------------------------------------
Buyer's Guide for a Operating System:
Don't care to know: Mac
Don't mind knowing but not too much: Windows
Hit me! I can take it!: Linux


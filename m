Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276534AbRJ2W5a>; Mon, 29 Oct 2001 17:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279370AbRJ2W5V>; Mon, 29 Oct 2001 17:57:21 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:44459 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S276534AbRJ2W5J>; Mon, 29 Oct 2001 17:57:09 -0500
Message-ID: <3BDDDF6A.B823F5C3@nortelnetworks.com>
Date: Mon, 29 Oct 2001 17:59:54 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: willy tarreau <wtarreau@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ethernet NIC dual homing
In-Reply-To: <20011029222609.81860.qmail@web20501.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

willy tarreau wrote:

> the 2.4 driver provides a mode which sends ARP packets
> to test the link (far more reliable than MII), and the
> appropriate ioctl for the NIC switch-over you need. It
> is available to user through ifenslave -c bond0 eth0
> for example.

Are there issues with using MII to detect link state?  I thought it was fairly
reliable...

How are you using arp packets to detect if the link is up?  Sending it out to
your own MAC address?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279588AbRJ2XHk>; Mon, 29 Oct 2001 18:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279589AbRJ2XHb>; Mon, 29 Oct 2001 18:07:31 -0500
Received: from web20508.mail.yahoo.com ([216.136.226.143]:9481 "HELO
	web20508.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S279588AbRJ2XHP>; Mon, 29 Oct 2001 18:07:15 -0500
Message-ID: <20011029230751.92486.qmail@web20508.mail.yahoo.com>
Date: Tue, 30 Oct 2001 00:07:51 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Ethernet NIC dual homing
To: Christopher Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BDDDF6A.B823F5C3@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are there issues with using MII to detect link
> state?  I thought it was fairly reliable...

no, there are examples with too long lines, or
scratched wires where the links stay up, but even arp
doesn't work.

> How are you using arp packets to detect if the link
> is up?  Sending it out to your own MAC address?

no, simply sending ARP request for a known IP address
which will reply, so generate traffic that can be
counted to tell wether a NIC seems working or not.

I didn't try to set my own IP address though. Perhaps
with arp_filter properly set this could be usefull...

Regards,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Courrier : http://courrier.yahoo.fr

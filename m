Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132299AbRCWBRj>; Thu, 22 Mar 2001 20:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132296AbRCWBR3>; Thu, 22 Mar 2001 20:17:29 -0500
Received: from smtprch2.nortelnetworks.com ([192.135.215.15]:32474 "EHLO
	smtprch2.nortel.com") by vger.kernel.org with ESMTP
	id <S132293AbRCWBR1>; Thu, 22 Mar 2001 20:17:27 -0500
Message-ID: <3ABAA2E6.9D40B7B6@asiapacificm01.nt.com>
Date: Fri, 23 Mar 2001 01:12:06 +0000
From: "Andrew Morton" <morton@nortelnetworks.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.2-ac19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lawrence Walton <lawrence@the-penguin.otak.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        Arjan van de Ven <arjan@fenrus.demon.nl>
Subject: Re: 2.4.2-ac21
In-Reply-To: <20010322162802.A909@the-penguin.otak.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <morton@asiapacificm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lawrence Walton wrote:
> 
> Hello all
> 2.4.2-ac21 seems to have a couple problems.
> ...
> 
> Mar 22 15:15:55 the-penguin kernel: NETDEV WATCHDOG: eth0: transmit timed out
> ...
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])

People have recently been changing VIA PCI bridge settings
to try to fix the file corruption thing.  There has been one
report that this change causes a 3c905C to go silly.

This looks like the same problem to me.

Arjan?

-

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291487AbSB0CPR>; Tue, 26 Feb 2002 21:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291446AbSB0CPH>; Tue, 26 Feb 2002 21:15:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7552 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291436AbSB0COv> convert rfc822-to-8bit;
	Tue, 26 Feb 2002 21:14:51 -0500
Date: Tue, 26 Feb 2002 18:12:50 -0800 (PST)
Message-Id: <20020226.181250.29574964.davem@redhat.com>
To: pasik@iki.fi
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        linux-net@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0202262003241.10668-100000@edu.joroinen.fi>
In-Reply-To: <20020225.165914.123908101.davem@redhat.com>
	<Pine.LNX.4.33.0202262003241.10668-100000@edu.joroinen.fi>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pasi Kärkkäinen <pasik@iki.fi>
   Date: Tue, 26 Feb 2002 20:08:51 +0200 (EET)
   
   Does/Will this driver support NICE-extensions as does the Broadcom's
   driver? I've been successfully using broadcom's driver with the
   nice-patched vlan-code for a couple of months now..

NICE is a gross hack and I would hope that Ben Greear would have
better taste in the interface he chooses for hw VLAN acceleration in
the 802.1q layer :-)

NICE was explicitly left out and this was done on purpose.

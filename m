Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263925AbRFNTEJ>; Thu, 14 Jun 2001 15:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263927AbRFNTDt>; Thu, 14 Jun 2001 15:03:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54194 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263925AbRFNTDh>;
	Thu, 14 Jun 2001 15:03:37 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15145.2693.704919.651626@pizda.ninka.net>
Date: Thu, 14 Jun 2001 12:03:33 -0700 (PDT)
To: Jonathan Lundell <jlundell@pobox.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Tom Gall <tom_gall@vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <p0510030eb74ea25caa73@[207.213.214.37]>
In-Reply-To: <3B273A20.8EE88F8F@vnet.ibm.com>
	<3B28C6C1.3477493F@mandrakesoft.com>
	<15144.51504.8399.395200@pizda.ninka.net>
	<p0510030eb74ea25caa73@[207.213.214.37]>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jonathan Lundell writes:
 > As I recall, even a midline chipset such as the ServerWorks LE 
 > supports the use of two north bridges, which implies two PCI bus 
 > domains.

It hides this fact by making config space accesses respond in such a
way that it appears that it is all behind one PCI controller.  The
BIOS even avoids allowing any of the MEM and I/O resources from
overlapping.

Later,
David S. Miller
davem@redhat.com


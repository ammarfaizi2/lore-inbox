Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274767AbRIUSHv>; Fri, 21 Sep 2001 14:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274771AbRIUSHl>; Fri, 21 Sep 2001 14:07:41 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:28170 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S274767AbRIUSHb>; Fri, 21 Sep 2001 14:07:31 -0400
Message-ID: <3BAB8246.A688EF44@t-online.de>
Date: Fri, 21 Sep 2001 20:09:10 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parport_pc.c PnP BIOS sanity check
In-Reply-To: <3BAAD796.A766FBEC@yahoo.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Hood wrote:
> 
> I'm still wondering why this function in parport_pc.c rejects dma
> values of zero.  Is DMA0 not usable by the parallel port for some
> reason?  I should think that if the PnP BIOS returns a dma of zero
> then it means that the parallel port is using DMA0.  Sorry if I'm
> being obtuse.                      // Thomas Hood

1)
  I think I saw some BIOS report DMA0 for "none" (could even have
  been ACPI which is returning PNP formatted legacy resource data).

2)
  I have never seen DMA0 for parport configured by a BIOS.

3)
  Try "lssuperio" if you want the real hardware thing.

This qualifies the code as it is as a sanity check.

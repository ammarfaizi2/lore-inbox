Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317152AbSFKQNX>; Tue, 11 Jun 2002 12:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317154AbSFKQNW>; Tue, 11 Jun 2002 12:13:22 -0400
Received: from [62.70.58.70] ([62.70.58.70]:60801 "EHLO newmail")
	by vger.kernel.org with ESMTP id <S317152AbSFKQNV> convert rfc822-to-8bit;
	Tue, 11 Jun 2002 12:13:21 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: IDE configuration trouble
Date: Tue, 11 Jun 2002 18:13:21 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200206111813.21200.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I apologize if this is OT, but I've tried looking around, and still can't find 
an answer, so here it goes.

I'm trying to set up a computer with the following configuration:

16 IBM 120GB IDE drives:
	On-board VIA controller with 4 drives
	Two promise ATA100 controllers with 4 drives each
	One CMD649U controller with 4 drives

Problem seems to be that the motherboard has addressed them on the PCI bus as 
follows:

Promise (1) 0.0c.00 (ide[01])
Promise (2) 0.0d.00 (ide[23])
CMD649U 0.0f.00 (ide[45])
VIA 0.10.1 (ide[67])

This gives me the VIA controller, which that motherboard wants to boot from, 
as the last controllers, which messes up all installers I've tried (though 
that's only Redhat and SuSE).

How can I force PCI 0.10.1 to be ide[01]?

Thanks all

Please cc: to me as I'm not on the list

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.


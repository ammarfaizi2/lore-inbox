Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWESImr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWESImr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 04:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWESImr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 04:42:47 -0400
Received: from web25807.mail.ukl.yahoo.com ([217.12.10.192]:57765 "HELO
	web25807.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932155AbWESImq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 04:42:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
  b=Sgy20F3JJhKtTDg48i/7mE+g+gUz4niHhoxiPi2dYXm/1VksMCPxF50S/tiOOE376YfXte8t7CXnoVFzByTr5KjDyBzVeu3QwoC0/szmywTb5NFR0dTCVnKPVHUfl5gv5XPP0t1P2dl1zXoCvaaFHDeKNER/6Gu2NjSV2gDsf8M=  ;
Message-ID: <20060519084245.19195.qmail@web25807.mail.ukl.yahoo.com>
Date: Fri, 19 May 2006 08:42:45 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: [I2C] question on adapter design
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm about writing a I2C bus adapter driver and wondering if it worth
to use interrupt for transfering data on the bus or just polling is
good enough ?

My hardware has a 8 bytes fifo for both Tx/Rx. It can generates
an interrupt when Tx fifo is empty and Rx fifo is not empty, 
actually like any UARTs. My CPU speed is 96 Mhz.

Thanks for your advices

Francis



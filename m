Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316085AbSEJR6R>; Fri, 10 May 2002 13:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316087AbSEJR6P>; Fri, 10 May 2002 13:58:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4290 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316085AbSEJR6N>;
	Fri, 10 May 2002 13:58:13 -0400
Date: Fri, 10 May 2002 10:46:05 -0700 (PDT)
Message-Id: <20020510.104605.71194376.davem@redhat.com>
To: zaitcev@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tcp/ip offload card driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200205101755.g4AHtqw04422@devserv.devel.redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pete Zaitcev <zaitcev@redhat.com>
   Date: Fri, 10 May 2002 13:55:52 -0400

   > For example, do a SpecWEB run with TUX both using on-chip-TCP and
   > without, same networking card.  Show a demonstrable gain from the
   > on-chip-TCP implementation.  I bet you can't.
   
   NO! Doing such a test sets you up for a failure. If a vendor
   of the card provides an on-chip TCP, it is entirely in the
   vendor's interest to penalize regular TCP (for example, by
   failing to provide checksum offload or sane S/G segments).
   
   I only consider fair a test of on-chip TCP compared to
   the best of the normal NICs.
   
Sorry, I should have stated this explicitly.  The same card
must have SG/Checksumming capability for the no-TCP-onchip portion of
the test.


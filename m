Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268417AbTBYXL6>; Tue, 25 Feb 2003 18:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268407AbTBYXL6>; Tue, 25 Feb 2003 18:11:58 -0500
Received: from maild.telia.com ([194.22.190.101]:38633 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S268417AbTBYXL5>;
	Tue, 25 Feb 2003 18:11:57 -0500
X-Original-Recipient: linux-kernel@vger.kernel.org
Date: Wed, 26 Feb 2003 00:21:30 +0100 (CET)
Message-Id: <20030226.002130.33211231.cfmd@swipnet.se>
To: mikael.starvik@axis.com
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org, tinglett@vnet.ibm.com,
       torvalds@transmeta.com
Subject: Re: zImage now holds vmlinux, System.map and config in sections.
 (fwd)
From: Magnus Danielson <cfmd@swipnet.se>
In-Reply-To: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE84C@mailse01.axis.se>
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE84C@mailse01.axis.se>
X-Mailer: Mew version 3.1 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikael Starvik <mikael.starvik@axis.com>
Subject: RE: zImage now holds vmlinux, System.map and config in sections. (fwd)
Date: Tue, 25 Feb 2003 07:28:46 +0100

> >I don't know linker scripts very well.
> >Can this be done for all architectures?
> >I'd like to see a solution that is arch-independent.
> 
> In embedded systems it is probably not desirable to keep 
> System.map and config in zImage (takes too much valuable space).

Exactly. Your trying to round up all the floobydust you can for the production
binaries. However, for others it may be a good patch. Ability to leave out is
what would make both camps happy.

Cheers,
Magnus

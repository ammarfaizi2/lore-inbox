Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265125AbSJVTnl>; Tue, 22 Oct 2002 15:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265126AbSJVTnl>; Tue, 22 Oct 2002 15:43:41 -0400
Received: from palrel10.hp.com ([156.153.255.245]:29146 "HELO palrel10.hp.com")
	by vger.kernel.org with SMTP id <S265125AbSJVTnk>;
	Tue, 22 Oct 2002 15:43:40 -0400
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, grundler@cup.hp.com
Subject: Re: [RFC] Debugging posted PCI writes 
In-Reply-To: Your message of "Tue, 22 Oct 2002 19:00:46 BST."
             <20021022190046.C27461@parcelfarce.linux.theplanet.co.uk> 
References: <20021022190046.C27461@parcelfarce.linux.theplanet.co.uk> 
Date: Tue, 22 Oct 2002 12:49:16 -0700
From: Grant Grundler <grundler@cup.hp.com>
Message-Id: <20021022194917.04A9712C2F@debian.cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
...
> Perhaps a timer that writes the queue every second would help?  It may
> be considered unreasonable for writes to be delayed _indefinitely_.

it is. that's what I was warning you about. need a timer to push
writes out every jiffie or so.

overall this is a great idea that was discussed at OLS/kernel summit.

grant

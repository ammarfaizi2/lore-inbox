Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbSLTVVg>; Fri, 20 Dec 2002 16:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265708AbSLTVVg>; Fri, 20 Dec 2002 16:21:36 -0500
Received: from palrel13.hp.com ([156.153.255.238]:32142 "HELO palrel13.hp.com")
	by vger.kernel.org with SMTP id <S265711AbSLTVVf>;
	Fri, 20 Dec 2002 16:21:35 -0500
Date: Fri, 20 Dec 2002 13:29:21 -0800
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.x disable BAR when sizing
Message-ID: <20021220212921.GF21823@cup.hp.com>
References: <20021220195031.GC21823@cup.hp.com> <Pine.LNX.3.95.1021220153107.23463A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1021220153107.23463A-100000@chaos.analogic.com>
User-Agent: Mutt/1.4i
From: grundler@cup.hp.com (Grant Grundler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 03:37:49PM -0500, Richard B. Johnson wrote:
> I don't think it has anything to do with the bridge. It has
> to do with the BAR for the video device.

It seems you missed something in the conversation.
The case in question is a PCI bridge forwarding MMIO transactions
to a PCI VGA device.

grant

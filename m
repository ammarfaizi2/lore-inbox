Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293348AbSBYIfA>; Mon, 25 Feb 2002 03:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293349AbSBYIeu>; Mon, 25 Feb 2002 03:34:50 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:51169 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S293348AbSBYIed>; Mon, 25 Feb 2002 03:34:33 -0500
Date: Mon, 25 Feb 2002 10:22:19 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
In-Reply-To: <Pine.LNX.4.30.0202241827290.18853-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.44.0202251020430.8317-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Feb 2002, Roy Sigurd Karlsbakk wrote:

> Will this driver shut off the watchdog when /dev/watchdog is closed, or
> does it require an explicit shutdown message like Jakob Oestergaard's
> sbc60xxwdt driver?

Depends on wether CONFIG_WATCHDOG_NOWAYOUT is specified.

	Zwane



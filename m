Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265511AbUAJXiW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 18:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265528AbUAJXhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 18:37:52 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:25008 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265511AbUAJXhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 18:37:48 -0500
Date: Sun, 11 Jan 2004 00:37:33 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Gunter =?iso-8859-1?Q?K=F6nigsmann?= <gunter@peterpall.de>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] Synaptics rate switching
Message-ID: <20040110233733.GA24197@ucw.cz>
References: <Pine.LNX.4.53.0401091101170.1050@calcula.uni-erlangen.de> <200401100344.03758.dtor_core@ameritech.net> <200401100345.17211.dtor_core@ameritech.net> <Pine.LNX.4.53.0401102241130.1980@calcula.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0401102241130.1980@calcula.uni-erlangen.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 11:05:23PM +0100, Gunter Königsmann wrote:
> 
> Tried it. Doesn't change a thing. Means: I get about half the number of
> warning messages, but that just corresponds to half the number of packets.
> 
> 
> What helps a lot, but not to 100% (get bad keypresses anyway) is
> totally deactivating the ACPI. Killing all processes that access /proc/acpi
> seems again to help a bit.
> 
> And The number of Warnings seemingly increases with the labtop
> temperature... In a really cold room I get nearly no warnings at all.
> Jitter? Hardware, that is simply broken?
> 
> 
> Anyway, --- with Dmitrys patches I get hardly ever little bad events, just
> warnings --- and --- well... I can live with them,
> 

Can you check whether you've enabled usage of the ACPI timer for
timekeeping?

If yes, disable it.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

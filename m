Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265708AbUAKCUy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 21:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265710AbUAKCUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 21:20:54 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:10369 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265708AbUAKCUw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 21:20:52 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter.koenigsmann@gmx.de>,
       Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter@peterpall.de>
Subject: Re: [PATCH 1/2] Synaptics rate switching
Date: Sat, 10 Jan 2004 21:20:46 -0500
User-Agent: KMail/1.5.4
Cc: Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter@peterpall.de>,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.53.0401091101170.1050@calcula.uni-erlangen.de> <200401100345.17211.dtor_core@ameritech.net> <Pine.LNX.4.53.0401102241130.1980@calcula.uni-erlangen.de>
In-Reply-To: <Pine.LNX.4.53.0401102241130.1980@calcula.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200401102120.46956.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 January 2004 05:05 pm, Gunter Königsmann wrote:
> Tried it. Doesn't change a thing. Means: I get about half the number of
> warning messages, but that just corresponds to half the number of
> packets.
>
>
> What helps a lot, but not to 100% (get bad keypresses anyway) is
> totally deactivating the ACPI. Killing all processes that access
> /proc/acpi seems again to help a bit.
>
> And The number of Warnings seemingly increases with the labtop
> temperature... In a really cold room I get nearly no warnings at all.
> Jitter? Hardware, that is simply broken?
>

Actually, since you mentioned temperature.. is CPUFREQ active or does
the ACPI throttle your processor to a lower frequency if it gets hot?
 
Dmitry

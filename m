Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbUAKISW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 03:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265809AbUAKISW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 03:18:22 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:9187 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265808AbUAKISF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 03:18:05 -0500
Date: Sun, 11 Jan 2004 09:00:55 +0100 (CET)
From: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter@peterpall.de>
Reply-To: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter.koenigsmann@gmx.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter@peterpall.de>,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] Synaptics rate switching
In-Reply-To: <200401102120.46956.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.53.0401110845100.1177@calcula.uni-erlangen.de>
References: <Pine.LNX.4.53.0401091101170.1050@calcula.uni-erlangen.de>
 <200401100345.17211.dtor_core@ameritech.net> <Pine.LNX.4.53.0401102241130.1980@calcula.uni-erlangen.de>
 <200401102120.46956.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:6f0b4d165b4faec4675b8267e0f72da4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpufreq is deactivated for all tests, but seems not to make problems...

ACPI --- Pow... never thought of that... ...But sync losses occour even if
my labtop doesn't even see the need for switching on the CPU fan. Anyway,
povray makes the CPU really hot, and doesn't make things worse...

...and the problem occours directly after startup, too... Don't think this
will be the problem,

	Gunter.


On Yesterday, Dmitry Torokhov wrote:

>From: Dmitry Torokhov <dtor_core@ameritech.net>
>Date: Sat, 10 Jan 2004 21:20:46 -0500
>To: Gunter Königsmann <gunter.koenigsmann@gmx.de>,
>     Gunter Königsmann <gunter@peterpall.de>
>Cc: Gunter Königsmann <gunter@peterpall.de>, linux-kernel@vger.kernel.org,
>     Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>
>Subject: Re: [PATCH 1/2] Synaptics rate switching
>
>On Saturday 10 January 2004 05:05 pm, Gunter Königsmann wrote:
>> Tried it. Doesn't change a thing. Means: I get about half the number of
>> warning messages, but that just corresponds to half the number of
>> packets.
>>
>>
>> What helps a lot, but not to 100% (get bad keypresses anyway) is
>> totally deactivating the ACPI. Killing all processes that access
>> /proc/acpi seems again to help a bit.
>>
>> And The number of Warnings seemingly increases with the labtop
>> temperature... In a really cold room I get nearly no warnings at all.
>> Jitter? Hardware, that is simply broken?
>>
>
>Actually, since you mentioned temperature.. is CPUFREQ active or does
>the ACPI throttle your processor to a lower frequency if it gets hot?
>
>Dmitry
>

-- 
"I don't think they could put him in a mental hospital.  On the other
hand, if he were already in, I don't think they'd let him out."
	--fortune(6)

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263521AbRFFQIS>; Wed, 6 Jun 2001 12:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263523AbRFFQII>; Wed, 6 Jun 2001 12:08:08 -0400
Received: from ibis.worldnet.net ([195.3.3.14]:30470 "EHLO ibis.worldnet.net")
	by vger.kernel.org with ESMTP id <S263521AbRFFQID>;
	Wed, 6 Jun 2001 12:08:03 -0400
User-Agent: Microsoft-Outlook-Express-Macintosh-Edition/5.02.2022
Date: Wed, 06 Jun 2001 18:06:56 +0200
Subject: Re: temperature standard - global config option?
From: Chris Boot <bootc@worldnet.fr>
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: "David N. Welton" <davidw@apache.org>, Pavel Machek <pavel@suse.cz>
Message-ID: <B74421C0.F6F7%bootc@worldnet.fr>
In-Reply-To: <20010606155026.A28950@bug.ucw.cz>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Please, don't.
> 
> Use kelvins *0.1, and use them consistently everywhere. This is what
> ACPI does, and it is probably right.

I'm sorry, by I don't feel like adding 273 to every number I get just to
find the temperature of something.  What I would do is give configuration
options to choose the default (Celsius/centigrade, Kelvin, or [shudder]
Fahrenheit) then, when you need to print or output a temperature, send it
off to a common converter function so you don't repeat core all over the
place.

Just my 0.02 Eurocents (what an ugly word).

-- 
Chris Boot
bootc@worldnet.fr

"Modem error handling really su~c%dk,s.^D^D&x@R*cCKo#?CB,*o#?C!!b    %o#?
NO CARRIER


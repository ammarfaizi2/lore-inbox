Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbVLMIGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbVLMIGx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVLMIGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:06:53 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:19335 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751333AbVLMIGv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:06:51 -0500
Message-ID: <439E81F7.3040803@aitel.hist.no>
Date: Tue, 13 Dec 2005 09:10:31 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nix <nix@esperi.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux in a binary world... a doomsday scenario
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>	<1133807641.9356.50.camel@laptopd505.fenrus.org>	<4395BBDB.307@ti-wmc.nl> <200512061850.20169.luke-jr@utopios.org>	<4397EB7A.7030404@aitel.hist.no> <87hd9jvgvz.fsf@amaterasu.srvr.nix>	<439D66AF.3010801@aitel.hist.no> <87u0dew12h.fsf@amaterasu.srvr.nix>
In-Reply-To: <87u0dew12h.fsf@amaterasu.srvr.nix>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nix wrote:
[...]

>FWIW when glxgears is running, X consumes about 2% more CPU time
>than normal: it's almost impossible to detect.
>  
>
Sure - the load is low - and so is performance.  As if the machine
isn't really trying - perhaps the driver is waiting when there is
no need to wait.

>It sounds to me almost like direct rendering is disabled, which will of
>course have catastropic effects on performance. What does glxinfo say?
>  
>
No.  While it is bad, it is not as bad as sw rendering. Tuxracer
with sw rendering is unbearable - 2 seconds per frame or so!

>>         Most people don't seem to have performance problems,
>>with their radeons, so perhaps my card is a bit different and
>>don't fit the driver.
>>    
>>
>
>The X startup log can also be useful here. I've noticed that if you
>get the AGPMode wrong in either direction, the results can be
>catastrophic: if it's too low the card is terribly slow and if it's
>too high you soon get the X server hanging as it waits forever for
>the card to respond to something it hasn't had time to receive (or
>something like that, anyway).
>  
>
Well, there is no AGPmode for a PCI card, is there?

Helge Hafting

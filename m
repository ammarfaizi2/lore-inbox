Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbUABAPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 19:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbUABAPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 19:15:51 -0500
Received: from lbo.net1.nerim.net ([62.212.103.219]:45027 "EHLO
	gyver.homeip.net") by vger.kernel.org with ESMTP id S261957AbUABAPk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 19:15:40 -0500
Message-ID: <3FF4B829.8060406@inet6.fr>
Date: Fri, 02 Jan 2004 01:15:37 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: best AMD motherboard for Linux
References: <3FEF0AFD.4040109@yahoo.com> <20031228172008.GA9089@c0re.hysteria.sk> <3FEF0AFD.4040109@yahoo.com> <20031228174828.GF3386@DervishD> <20031229165620.GF30794@louise.pinerecords.com> <Pine.LNX.4.58.0312301144340.467@uberdeity> <20031230194203.GA8062@louise.pinerecords.com> <Pine.LNX.4.58.0312301354130.765@uberdeity> <20031231093929.GC8062@louise.pinerecords.com> <Pine.LNX.4.58.0312310914170.473@uberdeity> <3FF45307.7070508@inet6.fr> <Pine.LNX.4.58.0401011516110.437@uberdeity>
In-Reply-To: <Pine.LNX.4.58.0401011516110.437@uberdeity>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Derek Foreman wrote the following on 01/01/2004 10:44 PM :

> [...]
>
>There are features available in both the ati and nvidia closed source
>drivers that are not available in DRI.  If I want "full use" of my
>hardware, then DRI is does not "work best" for me.
>
>  
>

We could argue endlessly on that subject. Let's agree that what 
*practically* works best for one doesn't automatically for another. My 
"best" in "they can't work best" conclusion referred to the utopic 
bug-free, adaptable to whatever changes in new kernels happen during the 
21st century driver.

>
>What would probably happen, as has happened with the aureal vortex, is
>that someone would maintain the open source wrapper.
>

You can't bet on it. You don't know which assumptions the binary code 
part makes on kernel structures' layouts.

> Is nvidia aware of this issue?


Yes they are, a bug report was already filed to them when I searched 
before posting mine. For the text mode, according to the nvidia people 
answering on their support forums this seems to come from the various 
ways hardware are initialised depending on the actual VGA BIOS. For the 
software suspend problem that bites me now this is probably the lack of 
ACPI support in their driver they are already well aware of but as 
swsusp is a patch to the 2.4 (and now 2.6), I don't think they'll take a 
bug report seriously anyway.

>Better would be to return the laptop and follow Joel Jaeggli's advice
>from earlier in this same thread, but unfortunately that's probably not an
>option.
>
>  
>

This laptop was the best hardware I could buy for the money and my 
needs. In fact my problems with the nvidia driver weren't even supposed 
to exist as I first planned to go the XFree86 nv driver way (without 3D 
support as I don't need it). Unfortunately, the LCD panel isn't setup 
properly by the OSS driver version distributed with RH9. I didn't have 
time to try XFree86 CVS so proprietary I went...

>The closed source modules "work best" for me, as some of the code I play
>with uses vertex buffer objects.
>
>I realize that tomorrow nvidia could drop linux support, next week someone
>could discover that echo HI\ MOM > /dev/nvidiactl gives them a root shell.
>
>But for my situation, these things are an acceptable trade for the added
>toys.
>
>  
>
As I said I agree that "work best for me" is obviously a variable...

My e-mail was only meant to bring some facts to the discussion 
describing the problems with proprietary drivers not a "burn all unholy 
hardware without proper OSS driver" flamewar starter.
In the hope that will help cool things down a little, best regards and 
happy new year,

-- 
Lionel Bouton - inet6
---------------------------------------------------------------------
   o              Siege social: 51, rue de Verdun - 92158 Suresnes
  /      _ __ _   Acces Bureaux: 33 rue Benoit Malon - 92150 Suresnes
 / /\  /_  / /_   France
 \/  \/_  / /_/   Tel. +33 (0) 1 41 44 85 36
  Inetsys S.A.    Fax  +33 (0) 1 46 97 20 10
 


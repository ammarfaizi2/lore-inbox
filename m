Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267868AbTBRQ75>; Tue, 18 Feb 2003 11:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267875AbTBRQ75>; Tue, 18 Feb 2003 11:59:57 -0500
Received: from tag.witbe.net ([81.88.96.48]:35850 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S267868AbTBRQ7y>;
	Tue, 18 Feb 2003 11:59:54 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Randy.Dunlap'" <rddunlap@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Recovering .config from vmlinuz and System.map
Date: Tue, 18 Feb 2003 18:09:55 +0100
Message-ID: <015801c2d770$8ec77320$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20030218090103.01365887.rddunlap@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Randy,

Not sure if it's your patch that RH has included, but that was it,
the .config stuff in the kernel...

Thanks very much !

Regards,
Paul

Paul Rolland, rol@witbe.net
Witbe.net SA
Directeur Associe

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un
navigateur

"Some people dream of success... while others wake up and work hard at
it"

> -----Original Message-----
> From: Randy.Dunlap [mailto:rddunlap@osdl.org] 
> Sent: Tuesday, February 18, 2003 6:01 PM
> To: Paul Rolland
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Recovering .config from vmlinuz and System.map
> 
> 
> On Tue, 18 Feb 2003 15:29:16 +0100
> "Paul Rolland" <rol@as2917.net> wrote:
> 
> | I've a box running a linux 2.4.18-14 (RH stuff), for which 
> I've lost 
> | the .config file...
> | 
> | I've gone through a long .config recovery process by looking at the 
> | entries in System.map, changing the configuration, building the 
> | kernel, diffing the new System.map with the reference one, 
> again and 
> | again.
> | 
> | The diff process was done only on the symbol names and the 
> last diff 
> | states : diff -urN System.map-9 System.map-2.4.18-sound | less
> | --- System.map-9        Tue Feb 18 13:36:33 2003
> | +++ System.map-2.4.18-sound     Tue Feb 18 09:47:47 2003
> | @@ -10776,6 +10776,7 @@
> |  d __setup_str_console_setup
> |  d __setup_str_reserve_setup
> |  d startup.0
> | +d configs
> |  d zone_balance_ratio
> |  d zone_balance_min
> |  d zone_balance_max
> | 
> | Could someone direct me to where is located this "configs" 
> stuff that 
> | I can't find ?
> 
> I wrote an optional feature that stores kernel .config info 
> inside the 'vmlinux' file in an array named 'configs'.  I 
> don't know if it's included in your kernel or not.
> 
> Some patches for this in-kernel-config feature are available 
> at http://www.osdl.org/archive/rddunlap/patches/ikconfig/
> and it's in Alan Cox's 2.4.-recent patches.
> 
> --
> ~Randy
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136472AbRAZS6R>; Fri, 26 Jan 2001 13:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136473AbRAZS6H>; Fri, 26 Jan 2001 13:58:07 -0500
Received: from limes.hometree.net ([194.231.17.49]:11268 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S136472AbRAZS55>; Fri, 26 Jan 2001 13:57:57 -0500
To: linux-kernel@vger.kernel.org
Date: Fri, 26 Jan 2001 18:37:12 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <94sg4o$1o4$1@forge.intermeta.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
In-Reply-To: <Pine.SOL.4.21.0101261528190.16539-100000@red.csi.cam.ac.uk>, <Pine.GNU.4.32.0101260850150.23316-100000@hanuman.oobleck.net>
Reply-To: hps@tanstaafl.de
Subject: Re: hotmail not dealing with ECN
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kaboom@gatech.edu (Chris Ricker) writes:

>> If ECN is so wonderful, why doesn't anybody actually WANT to use it
>> anyway?

>Lots of people do.  Lots of other people (such as, in this case, hotmail)
>will never upgrade their software until the groundswell of complaints is
>more expensive than their perception of the cost of upgrading....

Well, I guess, this is the price we must pay for having a monoculture
(a Cisco-powered) internet. If the single source of routers, switches
and network components (speak: Cisco) makes a single mistake in a
release version of their software (speak: drop ECN frames), everyone
suffers.

Cisco: If I buy a _new_ PIIX oder LDIR today, do I get an ECN capable
IOS or not? If not, will my CCNA know about this and upgrade my Box
before deploying?

Everyone I know and their brothers, that use Cisco Equipment, have a
support contract with Cisco. Why not push an "mandatory upgrade" along
this path once the ECN leaves "experimental" status.

But I definitely agree with HPA, that forcing ECN in its current state
on all users is unacceptable.

Solution that I see: 

DaveM at RedHat ships Kernels with ECN enabled per default.
RedHat ships Distributions with net.ipv4.ip_ecn = 0 in /etc/sysctl.conf

Ah, the small bliss of diversity... ;-) (And this means not, running
both flavors of Linux, Debian _and_ RedHat... ;-) )

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

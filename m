Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTLCXze (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTLCXze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:55:34 -0500
Received: from adsl-68-78-201-244.dsl.klmzmi.ameritech.net ([68.78.201.244]:31752
	"EHLO mail.domedata.com") by vger.kernel.org with ESMTP
	id S262610AbTLCXza convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:55:30 -0500
From: tabris <tabris@tabris.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pac1 (and others) issue with PDC20265
Date: Wed, 3 Dec 2003 18:55:07 -0500
User-Agent: KMail/1.5.3
References: <200312031610.34288.tabris@tabris.net>
In-Reply-To: <200312031610.34288.tabris@tabris.net>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200312031855.16902.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 03 December 2003 4:10 pm, tabris wrote:
> I have an ASUS A7V266-E motherboard, AMD AthlonXP 1800+ CPU.
> several hard drives of various makes.
>
> I've tested a couple different kernels... all (afaik) with preempt.
> I've tried 2.4.22-10mdk, plus 2.4.23-pac1+preempt+lowlatency, and also
> a 2.4.22-ac4+preempt
I also thought i should make mention of the slow and lost interrupts when 
copying from hdf->hdg, and not using DMA, and the fact that i have to set 
up a do loop in bash with ntpdate to keep the clock going. losing 6-12 
seconds every 15 seconds. (HZ=1000 and jif64 patch by Tim Schleimau 
applied, ported to -ac & -pac by me)
Mouse is sluggish as well.

Sorry for the very grotty grammar. -ENOCAFFEINE
- --
tabris
- -
They went rushing down that freeway,
Messed around and got lost.
They didn't care... they were just dying to get off,
And it was life in the fast lane.
		-- Eagles, "Life in the Fast Lane"
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/znfe1U5ZaPMbKQcRAvNZAJ9laNiExPTel4n27GochvQ+GI2vKQCcD1KT
n15JAhq9QGQyoLRe9oK+oEo=
=6Ya+
-----END PGP SIGNATURE-----


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSHRMNi>; Sun, 18 Aug 2002 08:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSHRMNi>; Sun, 18 Aug 2002 08:13:38 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:30964 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314459AbSHRMNi>; Sun, 18 Aug 2002 08:13:38 -0400
Subject: Re: IDE?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Anton Altaparmakov <aia21@cantab.net>, alan@lxorguk.ukuu.org,
       Andre Hedrick <andre@linux-ide.org>, axboe@suse.de, bkz@linux-ide.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020818131515.A15547@ucw.cz>
References: <Pine.SOL.3.96.1020817004411.25629B-100000@draco.cus.cam.ac.uk>
	<Pine.LNX.4.44.0208161706390.1674-100000@home.transmeta.com> 
	<20020818131515.A15547@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 18 Aug 2002 13:16:04 +0100
Message-Id: <1029672964.15858.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-18 at 12:15, Vojtech Pavlik wrote:
> I'll make patches for 2.5 to bring the low-level driver cleanups back.
> Not just piix.c - also aec62xx.c and amd74xx.c - the last one was in 2.5
> for a LONG time already and I'm not particularly happy it got lost.
> 
> If desirable (What's your opinion, Alan?) I can make equivalent patches
> for 2.4 as well.

Look at 2.4.20-pre2-ac3 before you start doing that. A lot of cleanup
has been done, although there is plenty more left. A starter is to fix
the the ratemask/ratefilter stuff to not use silly while loops on the
aec/amd drivers if you are hacking on those, stick in the static
variables and document anything relevant looking.

Simple stuff first.

Alan


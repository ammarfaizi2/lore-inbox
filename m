Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSIAF4E>; Sun, 1 Sep 2002 01:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSIAF4E>; Sun, 1 Sep 2002 01:56:04 -0400
Received: from [64.6.248.2] ([64.6.248.2]:12496 "EHLO greenie.frogspace.net")
	by vger.kernel.org with ESMTP id <S315265AbSIAF4D>;
	Sun, 1 Sep 2002 01:56:03 -0400
Date: Sat, 31 Aug 2002 23:00:18 -0700 (PDT)
From: Peter <cogweb@cogweb.net>
X-X-Sender: cogweb@greenie.frogspace.net
To: linux-kernel@vger.kernel.org
Subject: 2.4.xx IDE development policy
Message-ID: <Pine.LNX.4.44.0208312204080.13065-100000@greenie.frogspace.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm confident that the development of IDE drivers for 2.4 is in excellent
hands, with Alan and Andre working together. Still, the IDE drivers on the
popular Promise cards have been unstable for a while now, and things have 
clearly gone from quite good to worse.

Andre appears to be faced with very buggy and idiosyncratic hardware, and
the recent problems have been introduced in the attempt to accomodate for
this. Personally, for instance, I'm still running 2.4.16 with Andre's
patch on a Promise '69 and a 160GB drive, and I've never had a hint of a
problem -- heavy use over networks for months. Now people are reporting
serious problems with this card.

Non-functioning harddrives is obviously not as bad as losing data, but
still this is a bummer, man. How about a development policy to consolidate
progress and reduce the complexity of the task? Something like, Promise
cards that operate to spec get left alone. Idiosyncratic cards get an
experimental label and warnings, maybe only unofficial support through
patches, or they get marked as bad.

Add a diagnostic to the documentation. Let people bug the vendor about out 
of spec hardware. 

Linus commented earlier on how ATA development drives people up the wall; 
we just had one person burn out. So let's do something about it. 

Cheers,
Peter



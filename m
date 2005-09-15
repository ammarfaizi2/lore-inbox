Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030489AbVIOPOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030489AbVIOPOO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 11:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030492AbVIOPOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 11:14:14 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:6880 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S1030489AbVIOPON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 11:14:13 -0400
Message-ID: <43298F5C.10900@cs.aau.dk>
Date: Thu, 15 Sep 2005 17:12:28 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: adding new lsm hooks
References: <20050915145713.90231.qmail@web30704.mail.mud.yahoo.com>
In-Reply-To: <20050915145713.90231.qmail@web30704.mail.mud.yahoo.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

umesh chandak wrote:
> respected sir ,

Hum, you should skip this or my ego will blow up.

> Basically i want to add hooks at mac layer .But for
> time being as a practice i want to add new hooks of
> any type for playing purpose .so can you tell me a
> procedure or appropriate link

Sorry, but I don't see your point here...

You want to be able to restrict the access to a network card on the
basis of the MAC address ?

But, why don't you consider using the socket_create (and more generally,
the socket_* family) in place of adding new hooks ?

The point of a hook is to insert check-points to prevent people to
access features/data on the system. I hardly see the mac layer as a
feature/data by itself as it is part of "can I access network or not ?".

I might as well have missed your point, respected Sir (may I call you
respected Sir ?). :)

Regards
-- 
Emmanuel Fleury

Elegance is not optional.
  -- Richard O'Keefe

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129351AbQKARLR>; Wed, 1 Nov 2000 12:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129330AbQKARLH>; Wed, 1 Nov 2000 12:11:07 -0500
Received: from c90610-a.alton1.il.home.com ([24.11.42.157]:772 "EHLO
	www.linuxnet") by vger.kernel.org with ESMTP id <S129096AbQKARKw>;
	Wed, 1 Nov 2000 12:10:52 -0500
Date: Wed, 1 Nov 2000 11:10:46 -0600 (CST)
From: matthew <matthew@mattshouse.com>
To: Sean Hunter <sean@dev.sportingbet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10 Sluggish After Load
In-Reply-To: <20001101152629.B31394@bart.dev.sportingbet.com>
Message-ID: <Pine.LNX.4.21.0011011107170.7127-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Sean Hunter wrote:

> Pardon my speculations (if I am wrong), but isn't this an oracle question?  


It could be.


> Isn't oracle killing the server by trying to clean up 1800 connections all at
> once?  When they're all connected, most of the work is done by one or two
> oracle processes, but when you kill your ddos thing, all of the oracle
> listeners (of which there is one per connection), steam in and try to clean up.


Yes, but the factor that drove me to the list was that it's been > 400
load average for 10 hours now.  Even if Oracle tried to clean up 1800
connections at once, would it take this long?  That's not rhetorical, as
the answer may well be "yes".


> I thought oracle had an internal connection limit (on our servers it is set to
> 440 connections), anyways.


This is set in the init.ora.  I jacked it up to allow > 2000 connections.

Matthew


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

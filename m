Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTE0SAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbTE0R7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:59:25 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:63465 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S264012AbTE0R6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:58:33 -0400
Date: Tue, 27 May 2003 14:09:43 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.70
In-Reply-To: <Pine.LNX.4.44.0305271024060.6597-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.33.0305271402420.4448-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 May 2003, Linus Torvalds wrote:
>On Tue, 27 May 2003, Ricky Beam wrote:
>>
>> Count up the number of drivers that haven't been updated to the current
>> PCI, hotplug, and modules interfaces.
>
>Tough. If people don't use them, they don't get supported. It's that easy.
...

Allow me to clarify... I don't mind drivers not working.  I *do* mind
drivers emitting hundreds of warnings and errors because dozens of things
were changed and no one cared to update everything they broke.  In some
cases, fixing things may be simple (eg. someone removed or renamed a field
in a struct somewhere) and in others years of work my be required (eg.
the new module interface.)

In my opinion (as it was in the long long ago), everything in a "stable"
release should at least compile cleanly -- "working" comes later after
users have been conned into using it.

--Ricky



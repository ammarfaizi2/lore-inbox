Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266101AbUANJio (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265113AbUANJin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:38:43 -0500
Received: from [135.196.1.218] ([135.196.1.218]:24282 "EHLO
	pat.aberdeen.paradigmgeo.com") by vger.kernel.org with ESMTP
	id S265578AbUANJg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:36:58 -0500
Message-ID: <798DD0DBF172864C8CC752175CF42BA326C8B4@pat.aberdeen.paradigmgeo.com>
From: Paul Symons <PaulS@paradigmgeo.com>
To: "'Dave Jones '" <davej@redhat.com>,
       "'Nick Craig-Wood '" <ncw1@axis.demon.co.uk>
Cc: Paul Symons <PaulS@paradigmgeo.com>,
       "''linux-kernel@vger.kernel.org' '" <linux-kernel@vger.kernel.org>
Subject: RE: kernel oops 2.4.24
Date: Wed, 14 Jan 2004 09:36:48 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I wonder if you are thinking of the Nehemiah (the C3 mark 2) rather
>> than the Samuel which is on that board.  As far as I'm aware its only
>> safe to use i386 code and that is what we've been using very
>> succesfully (with a Debian/stable installation).

> Samuel (and all other pre-Nehemiah CPUs) can run i586 just fine.
> As the original poster said, they're i686 with missing CMOV extension,
> which in gcc-speak, is i586.
>
>		Dave

Yes, it seems to be the Samuel chip; uname -a describes it as "VIA Samuel 2
CentaurHauls". I made the step of returning to 2.6 yesterday (though I used
2.6.1 instead of 2.6.0 this time), because the oops's were becoming a bit of
a hindrance. However, I compiled for i386, and everything (so far) has
seemed stable. That's only been 15 hours, but fingers crossed anyway.

The thing that bemused me was that the system wasn't falling over with the
oops's, it just went a little wonky, and what's even more weird is that
sometimes it seemed to resolve its problems. for example, the first bunch of
oops's would occur, and ssh would consistently start bombing out on initial
connections. yet if i tried to connect about 30 minutes later, ssh would be
fine! i'm trying to upgrade to the most recent stable gcc to see what effect
that has. I was using 3.2.3 before.

I've installed memtest86 and will give it a run next time I have to reboot
the system.

Thanks for all the help and suggestions.

Paul

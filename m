Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131009AbRCFQxM>; Tue, 6 Mar 2001 11:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131014AbRCFQxB>; Tue, 6 Mar 2001 11:53:01 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:30292 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S131009AbRCFQwu>; Tue, 6 Mar 2001 11:52:50 -0500
Date: Tue, 6 Mar 2001 17:52:21 +0100 (CET)
From: Francis Galiegue <fg@mandrakesoft.com>
To: LA Walsh <law@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Annoying CD-rom driver error messages
In-Reply-To: <3AA510C6.7A2190D8@sgi.com>
Message-ID: <Pine.LNX.4.21.0103061750450.26329-100000@toy.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2001, LA Walsh wrote:

> 	So I'm still wondering what the "approved and recommended" way for a program
> to be "automatically" informed of a CD or floppy change/insertion and be able to
> informed of media 'type' w/o kernel warnings/error messages.  It sounds like
> there is no kernel support for this so far?
> 
> 	Then it seems the less ideal question is what is the "approved and recommended
> way for a program to "poll" such devices to check for 'changes' and 'media type'
> without the kernel generating spurious WARNINGS/ERRORS?
> 

The main problem is, in fact: none of floppy drives/IDE
floppies/CDROMs/whatever can do asynchronous medium change notifications (at
least not that I know of), so you'll need to poll anyway... And of course, the
commands to send depend on the device...

-- 
Francis Galiegue, fg@mandrakesoft.com - Normand et fier de l'être
"Programming is a race between programmers, who try and make more and more
idiot-proof software, and universe, which produces more and more remarkable
idiots. Until now, universe leads the race"  -- R. Cook


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751744AbWBWRC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbWBWRC4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbWBWRC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:02:56 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:52399 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751742AbWBWRCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:02:55 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 23 Feb 2006 18:01:09 +0100
To: schilling@fokus.fraunhofer.de, herbert@13thfloor.at
Cc: matthias.andree@gmx.de, linux-os@analogic.com,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] portable Makefiles (was: CD writing in future Linux 
 (stirring up a hornets' nest))
Message-ID: <43FDEA55.nailFWR71CX9O@burner>
References: <43F9D771.nail4AL36GWSG@burner>
 <200602201302.05347.dhazelton@enter.net>
 <43FAE10F.nailD121QL6LN@burner>
 <20060221101644.GA19643@merlin.emma.line.org>
 <43FAF2FA.nailD12BW90DH@burner>
 <20060221114625.GA29439@merlin.emma.line.org>
 <43FC68C1.nailEC711MJAV@burner>
 <20060223081257.GA28833@MAIL.13thfloor.at>
 <Pine.LNX.4.61.0602230802050.14236@chaos.analogic.com>
 <43FDE43B.nailFWR216SD6@burner>
 <20060223164254.GA482@MAIL.13thfloor.at>
In-Reply-To: <20060223164254.GA482@MAIL.13thfloor.at>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> wrote:

> > Who would waste his time with something like GNU make that is
> > unmaintained since more than 6 years?
> > 
> > If I need a bugfix in smake, I can do this in a few hours.
> > This is impossible with GNU make....
>
> just tried with GNU make, did work here within minutes :)

If you can fix things in GNU make within minutes, please fix the
bug that causes GNU make to complain about missing include files.

This is a self non-compliance as GNU make applies all so far known rules
on any other object before trying to use them (e.g. try to check out Makefile
from SCCS before complaining that Makefiles is missing).

If you need the correct algorithm, look into the smake source...

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily

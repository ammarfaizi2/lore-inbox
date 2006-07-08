Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWGHLTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWGHLTy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 07:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWGHLTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 07:19:54 -0400
Received: from khc.piap.pl ([195.187.100.11]:32203 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S964782AbWGHLTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 07:19:53 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Bill Davidsen <davidsen@tmr.com>, Benny Amorsen <benny+usenet@amorsen.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: ext4 features
References: <20060703205523.GA17122@irc.pl>
	<1151960503.3108.55.camel@laptopd505.fenrus.org>
	<44A9904F.7060207@wolfmountaingroup.com>
	<20060703232547.2d54ab9b.diegocg@gmail.com>
	<m3r711u3yk.fsf@ursa.amorsen.dk> <44AB3E4C.2000407@tmr.com>
	<20060707141030.GC4239@ucw.cz> <m38xn58g26.fsf@defiant.localdomain>
	<20060707213030.GA5393@ucw.cz> <m3odw0e5cu.fsf@defiant.localdomain>
	<20060708105532.GH1700@elf.ucw.cz>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 08 Jul 2006 13:19:52 +0200
In-Reply-To: <20060708105532.GH1700@elf.ucw.cz> (Pavel Machek's message of "Sat, 8 Jul 2006 12:55:32 +0200")
Message-ID: <m364i8e42v.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Why not? You use libextfs or how is it called to read the file from
> the disk directly (read-only access), then you write it back using
> regular calls.
>
> Of course, you can end up with "deleted" data being corrupted if
> kernel reused the area before undelete, or while you were doing
> undelete... but that's expected. They were _deleted_, right?

What if the "undeleted" file contained /etc/shadow because someone
was changing password at the time? :-)
-- 
Krzysztof Halasa

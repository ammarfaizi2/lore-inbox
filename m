Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbTJaEkb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 23:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbTJaEkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 23:40:31 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:63708 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S262973AbTJaEka
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 23:40:30 -0500
Date: Fri, 31 Oct 2003 17:38:19 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Announce: Swsusp-2.0-2.6-alpha1 [warning: eats disks with	loop!]
In-reply-to: <20031031025849.GA21818@atrey.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1067575098.16620.4.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1067064107.1974.44.camel@laptop-linux>
 <20031025204940.GB276@elf.ucw.cz> <1067153848.13594.49.camel@laptop-linux>
 <20031026092551.GB293@elf.ucw.cz> <1067163344.13594.170.camel@laptop-linux>
 <20031030080430.GB198@elf.ucw.cz> <1067542303.4041.9.camel@laptop-linux>
 <20031031025849.GA21818@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ouch!

I see if I can reproduce and fix the issue. Was the only unusual thing
the loop filesystem? I assume it was mounted rw.

Nigel

On Fri, 2003-10-31 at 15:58, Pavel Machek wrote:
> I made it to "work", unfortunately.
> 
> It seemed to suspend / resume okay, altrough suspend took *way* too
> long (like 1 minute without any apparent disk activity).
> 
> Unfortunately now my "main" filesystem (mounted via loop), is
> *gode*. Damaged beyond repair, I never managed to trash a filesystem
> this badly....
> 
> Tommorow I'll try to restore  from backup and run fsck from alternate
> superblock; cross your fingers for me.
> 
> 						Pavel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.


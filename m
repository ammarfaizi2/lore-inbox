Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267140AbTGOK5C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 06:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267166AbTGOK5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 06:57:02 -0400
Received: from dynast.gaugusch.at ([195.202.144.152]:27532 "EHLO
	dynast.gaugusch.at") by vger.kernel.org with ESMTP id S267140AbTGOK5A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 06:57:00 -0400
Date: Tue, 15 Jul 2003 13:11:09 +0200 (CEST)
From: Markus Gaugusch <markus@gaugusch.at>
To: Pavel Machek <pavel@suse.cz>
cc: Vojtech Pavlik <vojtech@suse.cz>, Jamie Lokier <jamie@shareable.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend
 enhancements
In-Reply-To: <20030715100842.GB3279@zaurus.ucw.cz>
Message-ID: <Pine.LNX.4.53.0307151305270.30306@dynast.gaugusch.at>
References: <20030713133517.GD19132@mail.jlokier.co.uk> <20030713193114.GD570@elf.ucw.cz>
 <1058130071.1829.2.camel@laptop-linux> <20030713210934.GK570@elf.ucw.cz>
 <1058147684.2400.9.camel@laptop-linux> <20030714201245.GC24964@ucw.cz>
 <20030714201804.GF902@elf.ucw.cz> <20030714204143.GA25731@ucw.cz>
 <20030714230219.GB11283@elf.ucw.cz> <20030715063612.GB27368@ucw.cz>
 <20030715100842.GB3279@zaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 15, Pavel Machek <pavel@suse.cz> wrote:
> ... and so I believe right thing is to make magic sysrq combination for
> aborting suspend...
Pavel,
SWSusp is mainly useful for desktop users. Although there may be cases
where it is enabled on production machines, it should be aimed at desktop
users as much as possible. The features to toggle reboot and abort suspend
are really, really cool. And combining them with sysrq would just make
them very very ugly. Someone mentioned the Gnome2 disaster, and I can only
second that. Configurability IS important. And it should be easy as well
(/proc is easy enough, good people or distributors can write a script and
provide it to end users, etc.).
To make the abort of swsusp configurable is the best compromise you can
have, IMHO. I don't know why you are so stubborn and don't try to see the
'normal' people (I'm not one of those, but I'm trying to understand!!).

Markus

-- 
__________________    /"\
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus@gaugusch.at     X     Against HTML Mail
                      / \

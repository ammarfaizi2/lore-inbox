Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267235AbUHTRQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267235AbUHTRQZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267338AbUHTRQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:16:25 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:61850 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S267235AbUHTRQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:16:23 -0400
Subject: Re: ati_remote for medion
From: Karel Demeyer <kmdemeye@vub.ac.be>
To: Tom Felker <tcfelker@mtco.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408191209.26139.tcfelker@mtco.com>
References: <1092904136.3352.5.camel@kryptonix>
	 <200408191016.06528.tcfelker@mtco.com> <1092930674.6966.6.camel@kryptonix>
	 <200408191209.26139.tcfelker@mtco.com>
Content-Type: text/plain; charset=utf-8
Date: Fri, 20 Aug 2004 19:16:47 +0200
Message-Id: <1093022207.2875.5.camel@kryptonix>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Actually, since the codes are different, we don't need separate tables, 
> because it shouldn't do any harm to have codes for the other remote in the 
> same table.  The remote sends a code, and we look it up in the table - as 
> long as there aren't two entries in the table with the same code, there's no 
> problem.
> 
> Anyway, please try the attached file.  I just put your codes on the bottom of 
> the key table, added your vendor/product ID to the device table, tore out the 
> check in probe() (as I think the system does this for us), and noted my 
> changes.
> 
> Hopefully the module doesn't freak out when other USB devices are plugged in 
> after the module is loaded, otherwise I can fix that.  And we still need to 
> add some comments / help text showing that we support the medion remote, and 
> maybe put your ascii art in somewhere.
> 
> 
> > Don't shoot me if I say anything irrevelant, and I'll stay around for
> > testing and stuff, even my evolution-filters arenot what they should be
> > - they copy it both in my Inbox and my 'Linux-kernel'-directory :|
> 
> That's my fault, I've been CC:ing you, so you get mail from both me and the 
> list.

Seems that the codes for the numbers are the same which is probvlematic
for me.  I mapped those keys as the keys in the "numlock-area" of the
keyboard.  I did it because I have a azerty-keyboard layout (be-latin1),
if I press the numbers it gives now &,é,",',(,§,... I also mapped the
numlock-button on the 'rename'-button right under the '7'-button (cfr.
ASCII-thingie in source).  This way I could them use as numbers and as
Home,PgUp,PgDn,Arrows... though I mapped those on ther keys too.

I think it will need 2 different tables thus :|  Maybe some other codes
are used twice now ... for other keys, I don't know as I didn't test it
alot and didn't look up in the source.

friendly greeting,

Karel "scapor" Demeyer


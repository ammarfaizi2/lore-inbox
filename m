Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030526AbWBNJUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030526AbWBNJUc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 04:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030527AbWBNJUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 04:20:32 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18917 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030526AbWBNJUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 04:20:31 -0500
Date: Tue, 14 Feb 2006 10:20:30 +0100
From: Martin Mares <mj@ucw.cz>
To: Marcin Dalecki <dalecki.marcin@neostrada.pl>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, jerome.lacoste@gmail.com,
       peter.read@gmail.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060214.091056.25971.atrey@ucw.cz>
References: <20060208162828.GA17534@voodoo> <20060210114721.GB20093@merlin.emma.line.org> <43EC887B.nailISDGC9CP5@burner> <200602090757.13767.dhazelton@enter.net> <43EC8F22.nailISDL17DJF@burner> <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com> <43F06220.nailKUS5D8SL2@burner> <mj+md-20060213.104344.18941.atrey@ucw.cz> <2D9D57EA-1197-4965-82ED-61DEAF73D9F9@neostrada.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2D9D57EA-1197-4965-82ED-61DEAF73D9F9@neostrada.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> This claim is a bit surprising since only, but the most irrelevant
> stuff from the dust bin of history, doesn't define a world global
> unique id those days.

That's unfortunately not true -- many USB devices don't have a usable
serial number.

Also, if I have a single device of its kind, let's say a USB mouse,
I really want to call it "The Mouse" and I don't want to reconfigure
anything if I plug it to a different port or replace it with a slightly
different mouse. All mice are considered equivalent by the user
as there is no reason to distinguish between them.

The same applies to CD burners -- as long as I have only one (which is
still the most common situation), I shouldn't have to think about how
to call it. Let it be just /dev/cdrw.

When I get multiple such devices, things start getting interesting, but
there is no single naming strategy which fits all uses. For example,
if I have two USB ports into which I connect USB disks various people
bring to me, it's convenient to call them "left" and "right", because
the serial number doesn't mean anything to me if I haven't seen the
device before. On the other hand, if I connect my own drives, it makes
sense to call them by their serial numbers or something like that.

I think that it's clear from all this, that device naming is a matter
of policy and that the best the OS can do is to give the users a way
how to specify their policy, which is what udev does.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
P.C.M.C.I.A. stands for `People Can't Memorize Computer Industry Acronyms'

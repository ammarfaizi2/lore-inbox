Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbWBHOIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbWBHOIf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 09:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbWBHOIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 09:08:35 -0500
Received: from loadbalancer1.orcon.net.nz ([219.88.242.3]:49385 "EHLO
	dbmail-mx4.orcon.co.nz") by vger.kernel.org with ESMTP
	id S965134AbWBHOIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 09:08:35 -0500
Date: Thu, 9 Feb 2006 03:12:04 +1300 (NZDT)
From: Keith Duthie <random@no.net.nz>
X-X-Sender: keith@hugin.graveyard.net.nz
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: jim@why.dont.jablowme.net, peter.read@gmail.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43E9F1CD.nail2BR11FL52@burner>
Message-ID: <Pine.LNX.4.64.0602090301190.25616@hugin.graveyard.net.nz>
References: <20060123105634.GA17439@merlin.emma.line.org>
 <200602021717.08100.luke@dashjr.org> <Pine.LNX.4.61.0602031502000.7991@yvahk01.tjqt.qr>
 <200602031724.55729.luke@dashjr.org> <43E7545E.nail7GN11WAQ9@burner>
 <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de>
 <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner>
 <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006, Joerg Schilling wrote:

> Sorry, but from reading the mail from _real_ cdrecord users, it is obvious
> that the people here are either not my users or users with a stange way of
> thinking.

I consider myself to be a real cdrecord user, and I find your SCSI ID
numbers to be incredibly annoying. With an external device the numbers
don't stay stable in any way shape or form, and generally change every
damned time the device is turned on.

Device names, on the other hand, do seem to be fairly stable, and are
actually meaningful (and can be made even more stable and meaningful
through creative use of udev). Why should I need to do a cdrecord -scanbus
when I can just use dev=/dev/scd0?

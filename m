Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWBCK6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWBCK6N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 05:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbWBCK6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 05:58:13 -0500
Received: from smtp10.wanadoo.fr ([193.252.22.21]:29363 "EHLO
	smtp10.wanadoo.fr") by vger.kernel.org with ESMTP id S1030182AbWBCK6M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 05:58:12 -0500
X-ME-UUID: 20060203105810239.3A85524000B6@mwinf1002.wanadoo.fr
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
From: Xavier Bestel <xavier.bestel@free.fr>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: oliver@neukum.org, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jerome.lacoste@gmail.com,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
In-Reply-To: <43E32884.nail5CA1O92YA@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	 <43DF3C3A.nail2RF112LAB@burner>
	 <5a2cf1f60601310424w6a64c865u590652fbda581b06@mail.gmail.com>
	 <200601311333.36000.oliver@neukum.org> <1138867142.31458.3.camel@capoeira>
	 <43E1EAD5.nail4R031RZ5A@burner> <1138880048.31458.31.camel@capoeira>
	 <43E20047.nail4TP1PULVQ@burner> <1138885334.31458.42.camel@capoeira>
	 <43E32884.nail5CA1O92YA@burner>
Content-Type: text/plain
Message-Id: <1138964278.23569.77.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Fri, 03 Feb 2006 11:57:58 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-03 at 10:55, Joerg Schilling wrote:
> Xavier Bestel <xavier.bestel@free.fr> wrote:
> > I understand your point, but believe me, *nobody* wants one HAL per
> > application. There need to be only one HAL for all, and as freedesktop's
> > HAL has the functionnality necessary for cdrecord (minus perhaps a few
> 
> If people don't want this confusion, why do they start with a new system?
> 
> libscg & cdrecord have been available long before Linux HAL was there.

Because libscg handles only SCSI, whereas HAL does work for all disk
types, floppies, serial ports, PCI buses, graphics cards, processors,
etc. Imagine there was one library per peripheral type - oh the pain.

> And the most important argument here is that it is extremely unlikely that
> this Linux HAL will handle all oddities of all CD/DVD-writers, do it is 
> unapropriate to use this interface in case that you like to get more 
> information than just "the drive is there".

For now, it sure doesn't equal cdrecord in that area. But give it time
and it will progress. After all, there's no reason HAL can't gain from
your expertise on the matter.

> Note that UNIX people usually believe that is is best practice to have this 
> kind of software intergrated in the kernel (or at leat in the system). This is 
> what FreeBSD did try for some years, and FreeBSD has failed with this attempt.

AFAIR this was deemed too complex to live in kernelspace. Maybe
FreeBSD's failure is a good indication it's true.

	Xav



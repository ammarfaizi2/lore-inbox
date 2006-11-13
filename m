Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933062AbWKMVX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933062AbWKMVX7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933060AbWKMVX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:23:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45741 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932687AbWKMVX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:23:58 -0500
Subject: Re: [linux-dvb] Avermedia 777 misbehaves after remote hack merged
	into v4l-dvb tree
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Michael Krufky <mkrufky@linuxtv.org>, "pasky@ucw.cz" <pasky@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       =?ISO-8859-1?Q?Jos=E9_Su=E1rez?= <j.suarez.agapito@gmail.com>,
       linux-dvb@linuxtv.org, linux-kernel <linux-kernel@vger.kernel.org>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
In-Reply-To: <4558DF23.5080207@linuxtv.org>
References: <200611131711.46626.j.suarez.agapito@gmail.com>
	 <45589E2E.7070304@linuxtv.org>
	 <Pine.LNX.4.64.0611130842010.22714@g5.osdl.org>
	 <4558DF23.5080207@linuxtv.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 13 Nov 2006 19:23:15 -0200
Message-Id: <1163453015.26319.29.camel@201-2-70-92.bsace705.w.brasiltelecom.net.br>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Seg, 2006-11-13 às 16:09 -0500, Michael Krufky escreveu:
> Linus Torvalds wrote:
> > 
> > On Mon, 13 Nov 2006, Michael Krufky wrote:
> >> Mauro -- that patch needs fixing / more testing before it goes to mainstream...
> >>
> >> Could you please remove that changeset from your git tree before Linus pulls it?
> > 
> > Too late. Already pulled and pushed out.
> > 
> > Looking at the patch, one obvious bug stands out: the new case statement 
> > for SAA7134_BOARD_AVERMEDIA_777 doesn't have a "break" at the end.
> > 
> > José, can you test this trivial patch and see if it fixes things?
Yes, this should fix the issue. It passed by my eyes :(

> Mauro, please pull from:
> 
> http://linuxtv.org/hg/~mkrufky/v4l-dvb
> 
> for the following:
> 
> - saa7134: Fix missing 'break' for avermedia card case

Ok, I've updated also master development tree at 
http://linuxtv.org/hg/v4l-dvb

Pasky,

Please test it also.

Cheers, 
Mauro.


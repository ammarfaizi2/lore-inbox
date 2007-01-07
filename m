Return-Path: <linux-kernel-owner+w=401wt.eu-S965166AbXAGVEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbXAGVEh (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 16:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbXAGVEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 16:04:37 -0500
Received: from smtp23.orange.fr ([193.252.22.30]:42452 "EHLO smtp23.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965166AbXAGVEg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 16:04:36 -0500
X-ME-UUID: 20070107210412824.C95121C00097@mwinf2346.orange.fr
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
From: Xavier Bestel <xavier.bestel@free.fr>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Sean <seanlkml@sympatico.ca>, Dave Jones <davej@redhat.com>,
       Alan <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
       Tilman Schmidt <tilman@imap.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0701072139520.4365@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	 <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr>
	 <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc>
	 <1168182838.14763.24.camel@shinybook.infradead.org>
	 <20070107153833.GA21133@flint.arm.linux.org.uk>
	 <20070107182151.7cc544f3@localhost.localdomain>
	 <20070107191730.GD21133@flint.arm.linux.org.uk>
	 <20070107200553.GA15101@redhat.com>
	 <20070107151514.be9430b1.seanlkml@sympatico.ca>
	 <Pine.LNX.4.61.0701072139520.4365@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sun, 07 Jan 2007 22:07:44 +0100
Message-Id: <1168204064.3806.40.camel@bip.parateam.prv>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 07 janvier 2007 à 21:40 +0100, Jan Engelhardt a écrit :
> >On Sun, 7 Jan 2007 15:05:53 -0500
> >Dave Jones <davej@redhat.com> wrote:
> >
> >> If there's something I should be doing when I commit that I'm not,
> >> I'll be happy to change my scripts.  My $LANG is set to en_US.UTF-8
> >> which should DTRT to the best of my knowledge, but clearly, that isn't
> >> the case.
> 
> No, LC_CTYPE defines what charset you use. (I may be wrong, though.)

IIRC LANG is a superset for all LC_* - i.e. if only LANG is defined, it
sets all your locales, but you can individually set the charset, numeric
format, date format, etc.

	Xav



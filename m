Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVC1P0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVC1P0T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 10:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbVC1P0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 10:26:18 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:12692 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S261884AbVC1PYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 10:24:12 -0500
Date: Mon, 28 Mar 2005 17:24:10 +0200
To: Andi Kleen <ak@muc.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, jmorris@redhat.com,
       herbert@gondor.apana.org.au
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
	(2.6.11)
Message-ID: <20050328152409.GE943@vanheusden.com>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast>
	<20050323203856.17d650ec.akpm@osdl.org> <m1y8cc3mj1.fsf@muc.de>
	<424324F1.8040707@pobox.com> <20050327171934.GB18506@muc.de>
	<20050327185500.GP943@vanheusden.com>
	<20050328152043.GA26121@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050328152043.GA26121@muc.de>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Reply-By: Sat Mar 26 23:38:20 CET 2005
X-MSMail-Priority: High
User-Agent: Mutt/1.5.6+20040907i
From: folkert@vanheusden.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > For joe-user imho it's better to do a check from a cronjob once a day. But for
> > high demand security, maybe make it pluggable? Like that a user can plug-in some
> > module which does the testing? Then you can have several kinds of tests
> > depending on your needs.
> In my old 2.4 patch there was a sysctl to turn off the kernel reseeding.
> If you turn it off you can do it in user space. That might be
> an option for the clinical paranoid. 
> BTW what do you do when the FIPS test fails? I dont see a good fallback
> path for this case.

Send a message to klogd and let read() block untill the test no longer fails.


Folkert van Heusden

Auto te koop! Zie: http://www.vanheusden.com/daihatsu.php
Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------= www.unixsoftware.nl =-+
Phone: +31-6-41278122, PGP-key: 1F28D8AE
Get your PGP/GPG key signed at www.biglumber.com!

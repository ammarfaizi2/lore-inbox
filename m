Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbTK2RlQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 12:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263801AbTK2RlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 12:41:16 -0500
Received: from news.cistron.nl ([62.216.30.38]:28091 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S263796AbTK2RlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 12:41:15 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Silicon Image 3112A SATA trouble
Date: Sat, 29 Nov 2003 17:41:14 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bqalnq$knf$1@news.cistron.nl>
References: <3FC36057.40108@gmx.de> <3FC8BDB6.2030708@gmx.de> <20031129165648.GB14704@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1070127674 21231 62.216.29.200 (29 Nov 2003 17:41:14 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031129165648.GB14704@gtf.org>,
Jeff Garzik  <jgarzik@pobox.com> wrote:
>Note that (speaking technically) the SII libata driver doesn't mask all
>interrupt conditions, which is why it's listed under CONFIG_BROKEN.  So
>this translates to "you might get a random lockup", which some users
>certainly do see.

That begs the question: is that going to be fixed ?

Also, the low performance of the IDE SII driver is because of
the bug with request-size (and the bad workaround). Was that
fixed in the libata version and if so is someone working on
porting that fix to the IDE version of the driver ?

Mike.


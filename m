Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbUK1A4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbUK1A4j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 19:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbUK1A4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 19:56:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33681 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261382AbUK1Azi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 19:55:38 -0500
Date: Sat, 27 Nov 2004 16:55:29 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: ub: oops with preempt ("Sahara Workshop") [u]
Message-ID: <20041127165529.088538fa@lembas.zaitcev.lan>
In-Reply-To: <1101591495.11949.42.camel@nosferatu.lan>
References: <20041123100247.2ea47e2d@lembas.zaitcev.lan>
	<1101591495.11949.42.camel@nosferatu.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Nov 2004 23:38:15 +0200, "Martin Schlemmer [c]" <azarah@nosferatu.za.org> wrote:
> On Tue, 2004-11-23 at 10:02 -0800, Pete Zaitcev wrote:

> > I admit that the code should be locked properly instead, but the global plan
> > is to drop all P3 tagged printks anyway. So let it be guarded for the moment.

> Sorry for the delay, but I have not had any time to really test this
> again.  I did some minor testing, and only after really working it,
> I could get an oops, but not nearly the same (think it was deeper into
> the scsi layer or maybe kobject stuff).

This is strange, because ub hasn't got any connection with SCSI layer.

Without trying to deflect the blame for improper locking in ub, I have to
ask, does it all work without the preempt for you?

-- Pete

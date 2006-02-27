Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751739AbWB0TRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbWB0TRT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWB0TRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:17:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45274 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751739AbWB0TRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:17:19 -0500
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <gregkh@suse.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20060227191108.GA9221@suse.de>
References: <20060227190150.GA9121@kroah.com>
	 <1141067298.2992.154.camel@laptopd505.fenrus.org>
	 <20060227191108.GA9221@suse.de>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 20:17:11 +0100
Message-Id: <1141067831.2992.156.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 2) the per interface description needs a "depends on config option"
> > field; not all options are always there, but depend on a config option
> > to be set. It makes a lot of sense to mark these as such so that users
> > KNOW they have to deal with the interface not being there occasionally,
> > depending on the kernel.
> 
> Hm, almost _everything_ is configurable these days, including sysfs.  Do
> we really want to keep the config value in sync with the kernel config
> system too?  I can add it, but it seems a bit unnecessary.


well there is "configurable" and "configurable"... but yeah. I don't
mean to document which config options it depends on, but more
"applications need to deal with this not being there since it's optional
and not uncommon to be disabled" or something.



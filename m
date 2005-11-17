Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbVKQVJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbVKQVJa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbVKQVJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:09:30 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:31467 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S964866AbVKQVJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:09:30 -0500
To: Dave Jones <davej@redhat.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Olivier Galibert <galibert@pobox.com>,
       <linux-pm@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
In-Reply-To: <20051117203731.GG5772@redhat.com>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com> <20051116164429.GA5630@kroah.com> <1132172445.25230.73.camel@localhost> <20051116220500.GF12505@elf.ucw.cz> <20051117170202.GB10402@dspnet.fr.eu.org> <1132257432.4438.8.camel@mindpipe> <20051117201204.GA32376@dspnet.fr.eu.org> <1132258855.4438.11.camel@mindpipe> <1132258855.4438.11.camel@mindpipe> <20051117203731.GG5772@redhat.com>
Date: Thu, 17 Nov 2005 21:09:07 +0000
Message-Id: <E1Ecr0F-0003TC-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:

> I don't know about other distros, but here's how that usually goes for Fedora users..

It Works in Ubuntu(TM)[0]. More seriously: recent alsa-libs should
provide a pile of stuff in /usr/share/alsa/cards which switches dmix on
by default in most cards[1]. Obviously, for this to work usefully, your
application needs to be using libalsa (either natively or using the aoss
wrapper).

[0] The only patch is to enable symbol versioning
[1] Not ones with hardware mixing
-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org

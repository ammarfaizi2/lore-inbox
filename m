Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWCHDTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWCHDTM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 22:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWCHDTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 22:19:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7100 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932405AbWCHDTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 22:19:10 -0500
Date: Tue, 7 Mar 2006 22:18:34 -0500
From: Dave Jones <davej@redhat.com>
To: Mark Lord <liml@rtr.ca>
Cc: Bill Davidsen <davidsen@tmr.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>, axboe@suse.de,
       albertcc@tw.ibm.com
Subject: Re: LibPATA code issues / 2.6.15.4
Message-ID: <20060308031829.GB5411@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Mark Lord <liml@rtr.ca>,
	Bill Davidsen <davidsen@tmr.com>, Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org,
	IDE/ATA development list <linux-ide@vger.kernel.org>, axboe@suse.de,
	albertcc@tw.ibm.com
References: <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046013.7070503@rtr.ca> <4404BAD6.3060009@tmr.com> <440E4803.7070808@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440E4803.7070808@rtr.ca>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 09:57:07PM -0500, Mark Lord wrote:
 > Bill Davidsen wrote:
 > >
 > >Is there a version of that which will build on x86? I grabbed the 
 > >version offered at freshmeat, but it won't compile on any x86 distro or 
 > >gcc version to which I have access. RH8, RH9, FC1, FC3, FC4, ubuntu... 
 > >with or without using the suggested alternate header.
 > 
 > hdparm-6.5 is the current version now.  Both it, and 6.4,
 > build/install/run cleanly on Ubunutu-5.10, Debian-Sarge,
 > and SLES9-SP3.
 > 
 > You seem to be having trouble on only Redhat distros..
 > I guess they've done something unfriendly again.
 > 
 > Care to be more specific about what Redhat is doing?

looks like our userspace includes aren't up to date with some of the kernel
changes, so currently they're lacking the ide_task_request_t and related
taskfile bits.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=184349

		Dave

-- 
http://www.codemonkey.org.uk

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968454AbWLEQx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968454AbWLEQx1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 11:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968456AbWLEQx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 11:53:27 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:53370 "EHLO
	mail.holtmann.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968454AbWLEQxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 11:53:25 -0500
Subject: Re: [PATCH 0/3] New firewire stack
From: Marcel Holtmann <marcel@holtmann.org>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
       linux-kernel@vger.kernel.org,
       Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <20061205160530.GB6043@harddisk-recovery.com>
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
	 <1165308400.2756.2.camel@localhost> <45758CB3.80701@redhat.com>
	 <20061205160530.GB6043@harddisk-recovery.com>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 17:53:55 +0100
Message-Id: <1165337635.2756.31.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erik,

> > >can you please use drivers/firewire/ if you want to start clean or
> > >aiming at replacing drivers/ieee1394/. Using "fw" as an abbreviation in
> > >the directory path is not really helpful.
> > 
> > Yes, that's probably a better idea.  Do you see a problem with using fw_* 
> > as a prefix in the code though?  I don't see anybody using that prefix, but 
> > Stefan pointed out to me that it's often used to abbreviate firmware too.
> 
> So what about fiwi_*? If that's too close to wifi_*, try frwr_.

please don't. These kind of abbreviations make my brain tilt. For the
directory name you basically should use the full name. In this case it
will be drivers/ieee1394/ or drivers/firewire/. Nothing else is really
acceptable and if you look at other subsystems, you will see that they
always use the long name.

For the exported public functions you might wanna use abbreviations, but
in general I don't recommend it. And normally we only talk about a
limited functions that are needed to be exposed via EXPORT_SYMBOL.

Regards

Marcel



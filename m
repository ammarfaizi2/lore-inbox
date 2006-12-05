Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937382AbWLEO1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937382AbWLEO1w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 09:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937376AbWLEO1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 09:27:52 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:53131 "EHLO
	mail.holtmann.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759846AbWLEO1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 09:27:51 -0500
Subject: Re: [PATCH 0/3] New firewire stack
From: Marcel Holtmann <marcel@holtmann.org>
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Cc: linux-kernel@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 09:46:40 +0100
Message-Id: <1165308400.2756.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kristian,

> I'm announcing an alternative firewire stack that I've been working on
> the last few weeks.  I'm aiming to implement feature parity with the
> current firewire stack, but not necessarily interface compatibility.
> For now, I have the low-level OHCI driver done, the mid-level
> transaction logic done, and the SBP-2 (storage) driver is basically
> done.  What's missing is a streaming interface (in progress) to allow
> reception and transmission of isochronous data and a userspace
> interface for controlling devices (much like raw1394 or libusb for
> usb).  I'm working out of this git repository:
> 
>   http://gitweb.freedesktop.org/?p=users/krh/juju.git
> 
> but I'll be sending 3 patches for review after this mail: first the
> core subsystem, then the OHCI driver and finally the SBP-2 (SCSI over
> firewire) driver.  For people who want to test this out, the easiest
> approach right now is to clone the git repo and run make.  This
> requires the kernel-devel RPM on Fedora Core; I'm sure other distros
> have a similar package.

can you please use drivers/firewire/ if you want to start clean or
aiming at replacing drivers/ieee1394/. Using "fw" as an abbreviation in
the directory path is not really helpful.

Regards

Marcel



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWBXXeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWBXXeu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 18:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWBXXeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 18:34:50 -0500
Received: from mail.gurulabs.com ([67.137.148.7]:57835 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S964784AbWBXXet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 18:34:49 -0500
Subject: Re: [Announce] Intel PRO/Wireless 3945ABG Network Connection
From: Dax Kelson <dax@gurulabs.com>
To: James Ketrenos <jketreno@linux.intel.com>
Cc: NetDev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <43FF88E6.6020603@linux.intel.com>
References: <43FF88E6.6020603@linux.intel.com>
Content-Type: text/plain
Date: Fri, 24 Feb 2006 16:34:50 -0700
Message-Id: <1140824090.3475.56.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-24 at 16:29 -0600, James Ketrenos wrote:
> Intel is pleased to announce the launch of an open source project to
> support the Intel PRO/Wireless 3945ABG Network Connection mini-PCI
> express adapter (IPW3945).

Cool!

>   In order to meet the requirements of all
> geographies into which our adapters ship (over 100 countries) we have
> placed the regulatory enforcement logic into a user space daemon that
> we provide as a binary under the same license agreement as the
> microcode.  We provide that binary pre-compiled as both a 32-bit and
> 64-bit application.  The daemon utilizes a sysfs interface exposed by
> the driver in order to communicate with the hardware and configure the
> required regulatory parameters.

It was exciting to watch the "centrino" wireless cards go from the least
supported cards in the Linux to the near the best G and A cards from a
feature and licensing stand point (modulo the firmware restart issues).

I have a ipw2200 and have recommended it and now the ipw2915 to anyone
who has asked (myself and ipw2xxx using co-workers have taught thousands
of students and decision makers in Linux classes worldwide).

It is very disappointing to see this binary user space daemon (that must
run as root, presumably to write into /sys/) requirement. I recognize
that it is a better poison than a binary kernel module.

At the point when I'm in the market for a mini-PCI express wireless
adapter I hope there are other cards available that don't require any
kernel or userland binary pieces. I'll vote with my wallet so to speak.

Dax Kelson
Guru Labs


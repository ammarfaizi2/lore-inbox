Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262799AbSJWDSd>; Tue, 22 Oct 2002 23:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262803AbSJWDSd>; Tue, 22 Oct 2002 23:18:33 -0400
Received: from mail.cyberus.ca ([216.191.240.111]:30692 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S262799AbSJWDSc>;
	Tue, 22 Oct 2002 23:18:32 -0400
Date: Tue, 22 Oct 2002 23:17:13 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Tim Hockin <thockin@hockin.org>
cc: David Woodhouse <dwmw2@infradead.org>, <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>
Subject: Re: rtnetlink interface state monitoring problems.
In-Reply-To: <200210230144.g9N1iDx11822@www.hockin.org>
Message-ID: <Pine.GSO.4.30.0210222313050.24323-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Oct 2002, Tim Hockin wrote:

> > If not, it probably time for someone to write a generic notification
> > scheme via netlink.
>
> How generic?  I need to pay some attention to cleaning up the next version
> of the link-changes via netlink patch that was discussed last week or the
> week before.

The patch posted by Stefan seems good to me and ready to merge.

>
> What kind of generic are you thinking about? :)
>

netlink is a messaging system; so what i am thinking is creating
a event notifier for other devices other than network devices.
Something other non-network devices could use (eg bluetooth).
Given that netlink packetizes the data, this facilitates a distributed
control type of environment.

cheers,
jamal


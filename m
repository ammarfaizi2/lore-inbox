Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbTFKVIl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTFKVIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:08:41 -0400
Received: from air-2.osdl.org ([65.172.181.6]:10667 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264477AbTFKVIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:08:31 -0400
Date: Wed, 11 Jun 2003 14:23:57 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: oprofile broken by sysfs updates
In-Reply-To: <20030611211220.GA634@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0306111421200.11379-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I only tried reading the diffs, but:

Then maybe you should

a) Read the entire initial thread (which you participated in), esp this 
message:

http://marc.theaimsgroup.com/?l=linux-kernel&m=105518049424749&w=2

b) Read the comments in the code (from drivers/base/sys.c):

/**
 *      sysdev_shutdown - Shut down all system devices.
 *
 *      Loop over each class of system devices, and the devices in each
 *      of those classes. For each device, we call the shutdown method for
 *      each driver registered for the device - the globals, the auxillaries,
 *      and the class driver. 
 *
 *      Note: The list is iterated in reverse order, so that we shut down
 *      child devices before we shut down thier parents. The list ordering
 *      is guaranteed by virtue of the fact that child devices are registered
 *      after their parents. 
 */

c) Try using the code and stop being a troll.


Thanks,

	-pat



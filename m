Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbTJGJID (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 05:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbTJGJID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 05:08:03 -0400
Received: from quechua.inka.de ([193.197.184.2]:42401 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261906AbTJGJIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 05:08:00 -0400
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: [RFC 0/6] Backing Store for sysfs
Date: Tue, 07 Oct 2003 11:08:17 +0200
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2003.10.07.09.08.17.115017@dungeon.inka.de>
References: <20031006085915.GE4220@in.ibm.com> <20031006160846.GA4125@us.ibm.com> <20031006173111.GA1788@in.ibm.com> <20031006173858.GA4403@kroah.com> <20031006180119.GC1788@in.ibm.com> <20031006180907.GA4611@kroah.com> <20031006183132.GD1788@in.ibm.com> <20031006183403.GA6274@kroah.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, not a 'find', we look up the kobject that was added, and its
> attributes.  Doing a 'find' will emulate this for your tests, that's
> all.

But coldplugging will more or less do a "find /sys" to get a list of
all existing devices and add those to /dev. So expect a "find /sys" 
to be run at least once in the early boot process. Coldplugging is
not yet implemented, but it's possible to simulate it with a bit
of shell scripting.

Andreas


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTKPNal (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 08:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTKPNal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 08:30:41 -0500
Received: from linux-bt.org ([217.160.111.169]:18883 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S262731AbTKPNak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 08:30:40 -0500
Subject: Re: Fix firmware loader docs
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
In-Reply-To: <20031116131000.GA293@elf.ucw.cz>
References: <20031116131000.GA293@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1068989412.17638.407.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 16 Nov 2003 14:30:12 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> AFAICS, sysfs should be mounted on /sys these days...

we can remove the hotplug-script from 2.4 and 2.6 completly, because the
firmware.agent script is now part of the linux-hotplug scripts and there
is no need to write one. You only have to put the firmware file into the
firmware directory, which is by default /usr/lib/hotplug/firmware/ and
everything works as expected.

Regards

Marcel



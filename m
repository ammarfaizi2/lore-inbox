Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTDKXTl (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbTDKXTk (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:19:40 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:32722 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S262482AbTDKXT3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 19:19:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Greg KH <greg@kroah.com>, Steven Dake <sdake@mvista.com>
Subject: Re: [ANNOUNCE] udev 0.1 release
Date: Sat, 12 Apr 2003 01:30:28 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20030411173018$2695@gated-at.bofh.it> <3E974348.7080104@mvista.com> <20030411230533.GH3786@kroah.com>
In-Reply-To: <20030411230533.GH3786@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304120130.28640.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 April 2003 01:05, Greg KH wrote:

> Multi-threaded device discovery is a good thing, it solves a lot of
> real-life problems that we have today.  But it's a 2.7 thing, not on the
> near horizon.

At least the device detection in drivers/s390/cio/ is already multi-threaded
in 2.5 and it significantly speeds up the boot process, so I don't want
to revert this.

	Arnd <><

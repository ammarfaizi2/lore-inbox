Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTDOFjC (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 01:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbTDOFjB (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 01:39:01 -0400
Received: from granite.he.net ([216.218.226.66]:55051 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264271AbTDOFjB (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 01:39:01 -0400
Date: Mon, 14 Apr 2003 22:52:26 -0700
From: Greg KH <greg@kroah.com>
To: Kees Bakker <kees.bakker@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67 Oops in usb_dump_interface after rmmod ov511
Message-ID: <20030415055226.GB8859@kroah.com>
References: <16025.44377.247003.44494@iris.hendrikweg.doorn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16025.44377.247003.44494@iris.hendrikweg.doorn>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 13, 2003 at 08:32:57PM +0200, Kees Bakker wrote:
> If I do a "cat /proc/bus/usb/devices" after removing the ov511 module I get
> an OOPS.
> Here is the info from my syslog:

Ouch, not good.

Does this happen for any other USB devices?

And can you add a bug to bugzilla.kernel.org for this, so I remember to
make sure it's fixed?  :)

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161504AbWJKVb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161504AbWJKVb6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161527AbWJKVb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:31:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1695 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161513AbWJKVbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:31:47 -0400
Date: Wed, 11 Oct 2006 14:29:41 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pavel Machek <pavel@suse.cz>, <gregkh@suse.de>,
       Paolo Abeni <paolo.abeni@email.it>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usbmon: add binary interface
Message-Id: <20061011142941.3c599e16.zaitcev@redhat.com>
In-Reply-To: <Pine.LNX.4.44L0.0610111649440.6437-100000@iolanthe.rowland.org>
References: <20061011134351.0c79445a.zaitcev@redhat.com>
	<Pine.LNX.4.44L0.0610111649440.6437-100000@iolanthe.rowland.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 16:51:09 -0400 (EDT), Alan Stern <stern@rowland.harvard.edu> wrote:

> Would relayfs be a better choice than debugfs for exporting potentially
> large quantities of binary data?

I'm sick of mounting them, so for the binary API I was going to
create a bunch of character devices with a dynamic major.
With udev, I do not even need to read /proc/devices myself.

Curiously enough, Marcel Holtmann argued for a device because he
did NOT want to run udev. Funny how that works.

-- Pete

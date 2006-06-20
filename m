Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWFTJOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWFTJOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbWFTJOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:14:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30122 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965086AbWFTJOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:14:02 -0400
Date: Tue, 20 Jun 2006 02:13:54 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Stephen Cameron <smcameron@yahoo.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Problem with Sandisk USB CF reader on 2.6.16.20
Message-Id: <20060620021354.8a516068.zaitcev@redhat.com>
In-Reply-To: <mailman.1150780443.1980.linux-kernel2news@redhat.com>
References: <mailman.1150780443.1980.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 19:41:07 -0700 (PDT), Stephen Cameron <smcameron@yahoo.com> wrote:

> I have a Sandisk USB compact flash reader.  this 
> worked with 2.6.16.11, but does not seem to work with
> 2.6.16.20.  Maybe a udev problem?

Lessee...

> I plug the device in, and cat /proc/partitions, but
> see nothing matching my usb device.

Not a udev problem then.

> I used the .config from my working 2.6.16.11 kernel
> when making the 2.6.16.20 kernel...
> (did "make oldconfig" iirc.)

I suppose you kept 2.6.16.11 around. So why don't you do the same
things on both, collect dmesg output with "dmesg > /tmp/11",
then diff them with diff -u /tmp/11 /tmp/20. That ought to show
something.

-- Pete

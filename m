Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265209AbTFMHDk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 03:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbTFMHDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 03:03:39 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:20240 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265209AbTFMHDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 03:03:35 -0400
Date: Fri, 13 Jun 2003 08:17:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steven Dake <sdake@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030613081719.A7976@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steven Dake <sdake@mvista.com>, linux-kernel@vger.kernel.org
References: <3EE8D038.7090600@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EE8D038.7090600@mvista.com>; from sdake@mvista.com on Thu, Jun 12, 2003 at 12:10:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 12:10:48PM -0700, Steven Dake wrote:
> Folks,
> 
> I have been looking at the udev idea that Greg KH has developed.  
> Userland device enumeration definately is the way to go, however, there 
> are some problems with using /sbin/hotplug to transmit device 
> enumeration events:

Given the comments already on the list I won't repeat commetning
on your attitued, but if you really think the maintainers and everyone
else is totally clueless you should probably start the mail with that
so every is aware of it..

So if you can prove the fork+exec really is a problem I'd suggest you
go for an existing, standard interface instead.  That would be netlink
and not some chardev ioctl hack..


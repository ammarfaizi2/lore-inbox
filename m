Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265054AbTFLWwQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265046AbTFLWuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:50:20 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:11255 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S265039AbTFLWt6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:49:58 -0400
Subject: Re: [PATCH] udev enhancements to use kernel event queue
From: Robert Love <rml@tech9.net>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@digeo.com>, sdake@mvista.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030612225040.GA1492@kroah.com>
References: <3EE8D038.7090600@mvista.com> <20030612214753.GA1087@kroah.com>
	 <20030612150335.6710a94f.akpm@digeo.com>  <20030612225040.GA1492@kroah.com>
Content-Type: text/plain
Message-Id: <1055459124.662.332.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 12 Jun 2003 16:05:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 15:50, Greg KH wrote:

> 	- serialize the hotplug events in userspace:
> 		- udev daemon running listening on named pipe
> 		- small event generator kicked off from /sbin/hotplug
> 		  call to write event to udev pipe

What if you just passed a sequence number to /sbin/hotplug ?

	Robert Love


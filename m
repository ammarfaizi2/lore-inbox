Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265338AbTLHFqQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 00:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265341AbTLHFqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 00:46:15 -0500
Received: from [66.62.77.7] ([66.62.77.7]:31659 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S265338AbTLHFqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 00:46:14 -0500
Subject: Re: USB/visor oops
From: Dax Kelson <dax@gurulabs.com>
To: Pete Zaitcev <zaitcev@redhat.com>, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200312071935.hB7JZxMc015085@devserv.devel.redhat.com>
References: <mailman.1070778724.26453.linux-kernel2news@redhat.com>
	 <200312071935.hB7JZxMc015085@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1070862306.2922.2.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 07 Dec 2003 22:45:06 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-12-07 at 12:35, Pete Zaitcev wrote:
> > After having had my Tre600 hotsyncing working fine with RHL9 I'm trying
> > again after upgrading to Fedora. So far all I get are oops and hangs.
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=107929
> 
> Try 2.4.23 as Greg says and LET ME KNOW THE RESULT, please.

It works great with 2.4.23! No oops, hotsync goes.

Greg question for you. Before I always used /dev/usb/ttyUSB0 to hotsync
against, now it that doesn't work but ttyUSB1 does. Any ideas?

> > This is with the Fedora kernel 2.4.22-1.2115.nptl. This is with the uhci
> > instead of usb-uhci.
> 
> Someone enabled it again? Time to have a talk with davej.

My system defaulted to usb-uhci. I tried uhci to see if it made a
difference. It didn't.

Dax Kelson
Guru Labs


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWBGW5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWBGW5l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWBGW5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:57:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17564 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030229AbWBGW5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:57:19 -0500
Date: Tue, 7 Feb 2006 14:59:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neal Becker <ndbecker2@gmail.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: 2.6.16-rc1 panic on startup (acpi)
Message-Id: <20060207145913.714fec1c.akpm@osdl.org>
In-Reply-To: <ds7f17$gp7$1@sea.gmane.org>
References: <ds7cu3$9c0$1@sea.gmane.org>
	<ds7f17$gp7$1@sea.gmane.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neal Becker <ndbecker2@gmail.com> wrote:
>
> Sorry, I meant 2.6.16-rc1 (not 2.6.12)
> 
> Neal Becker wrote:
> 
> > HP dv8000 notebook
> > 2.6.15 is fine, but 2.6.12-rc1 panics immediately on startup
> > 
> > Here is a picture of some traceback
> > https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=124152&action=view
> 
> 

It died in pci_mmcfg_read().  Greg, didn't a crash in there get fixed recently?

Neal, booting with `vga=extended' or similar will help prevent the oops
from scrolling off the display.

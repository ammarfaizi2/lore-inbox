Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUBREDt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUBREDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:03:49 -0500
Received: from mail.kroah.org ([65.200.24.183]:61870 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262328AbUBREDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:03:47 -0500
Date: Tue, 17 Feb 2004 20:03:42 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3rc4 compaq hotplug driver go bang on rmmod.
Message-ID: <20040218040342.GC6729@kroah.com>
References: <20040218025938.GA26304@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218025938.GA26304@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 02:59:38AM +0000, Dave Jones wrote:
> I notice this driver has got its pci_driver remove: method commented out.
> Greg, whats the thinking behind that? Surely we can do something
> better than the current ...

Ick.  I don't remember why that was done that way.  I'll make up a patch
tomorrow and add it to my pci tree.

Thanks for finding this.

greg k-h

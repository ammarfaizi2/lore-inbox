Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbUBWU3M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 15:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbUBWU1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 15:27:37 -0500
Received: from mail.kroah.org ([65.200.24.183]:3767 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262038AbUBWU12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 15:27:28 -0500
Date: Mon, 23 Feb 2004 12:23:13 -0800
From: Greg KH <greg@kroah.com>
To: Pat Gefre <pfg@sgi.com>
Cc: davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [2.6 PATCH] Altix hotplug
Message-ID: <20040223202313.GA22207@kroah.com>
References: <200402231455.i1NEtEqJ041950@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402231455.i1NEtEqJ041950@fsgi900.americas.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 08:55:14AM -0600, Pat Gefre wrote:
> 
> 2.6 Altix patch for kernel hotplug support

You mean "PCI hotplug support" right?

If so, how?  I do not see a single call to pci_hp_register() or friends
here.  What is the userspace interface to your pci hotplug system?

thanks,

greg k-h

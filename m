Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUBIUwC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 15:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264485AbUBIUwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 15:52:02 -0500
Received: from mail.kroah.org ([65.200.24.183]:55529 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264419AbUBIUwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 15:52:01 -0500
Date: Mon, 9 Feb 2004 12:51:55 -0800
From: Greg KH <greg@kroah.com>
To: "Jinu M." <jinum@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI based storage controller driver
Message-ID: <20040209205155.GA11762@kroah.com>
References: <1118873EE1755348B4812EA29C55A97212795B@esnmail.esntechnologies.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118873EE1755348B4812EA29C55A97212795B@esnmail.esntechnologies.co.in>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 07:11:19PM +0530, Jinu M. wrote:
> 
> Our main concern here is the way we can associate the device structure
> (our structure) and the PCI structure (pci_dev) to each of the memory
> devices based on just the minor number.

How does this differ from other block drivers that are using pci cards
to support them?

thanks,

greg k-h

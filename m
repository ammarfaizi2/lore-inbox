Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbTIPASs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 20:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbTIPASs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 20:18:48 -0400
Received: from mail.kroah.org ([65.200.24.183]:7593 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261676AbTIPASr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 20:18:47 -0400
Date: Mon, 15 Sep 2003 17:17:30 -0700
From: Greg KH <greg@kroah.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI probe, please CC hamilton@sedsystems.ca
Message-ID: <20030916001730.GA19930@kroah.com>
References: <3F66441F.3010206@sedsystems.ca> <20030915230949.GA18153@kroah.com> <3F6649A1.6070103@sedsystems.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F6649A1.6070103@sedsystems.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 05:22:09PM -0600, Kendrick Hamilton wrote:
> Greg,
>    We don't have a hardware address to use. What I am looking for is a 
> way to tie it to the slot number. Is there any way of getting the slot 
> number?

Again, do the pci bus ids change between boots?

And no, there usually is not a way to get to the slot number, except for
machines that happen to have a pci hotplug controller.  They usually
have some way to map from the slot to the pci devices.

thanks,

greg k-h

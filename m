Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264720AbUEaSEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264720AbUEaSEi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 14:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264717AbUEaSEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 14:04:38 -0400
Received: from mail.kroah.org ([65.200.24.183]:17102 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264715AbUEaSEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 14:04:37 -0400
Date: Mon, 31 May 2004 11:03:42 -0700
From: Greg KH <greg@kroah.com>
To: Pokey the Penguin <pokey@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psmouse/usb interaction fix
Message-ID: <20040531180341.GA17125@kroah.com>
References: <20040531174012.BA07D2B2B58@ws5-7.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040531174012.BA07D2B2B58@ws5-7.us4.outblaze.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 01:40:10AM +0800, Pokey the Penguin wrote:
> This patch fixes the case where certain laptop touchpads (ALPS) 
> are disabled if the machine boots with a usb mouse plugged in.
> 
> Without it, users have to choose between using either a usb mouse 
> or the touchpad. With it, any combination is possible and the usb 
> mouse can be attached/removed at runtime without breaking the 
> touchpad.
> 
> The patch is ported from a SuSE kernel to 2.6.7-rc2. It's been
> around for at least two minor releases. The maintainer was
> contacted regarding merging but failed to respond.
> 
> Patch vital to certain laptop users. Please apply.

But this breaks users who want BIOS usb support instead of native Linux
support, right?  Sure, there are not many people who want that, but I do
know people who rely on this (like installer kernels, and early boot
issues with USB keyboards.)

thanks,

greg k-h

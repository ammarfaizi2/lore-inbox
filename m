Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVBXSN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVBXSN7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 13:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbVBXSN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 13:13:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:60631 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261698AbVBXSN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 13:13:58 -0500
Date: Thu, 24 Feb 2005 10:13:47 -0800
From: Greg KH <greg@kroah.com>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 Mass storage device
Message-ID: <20050224181347.GA10847@kroah.com>
References: <20050224175918.GA7627@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224175918.GA7627@mail.muni.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 06:59:18PM +0100, Lukas Hejtmanek wrote:
> Hello,
> 
> I have a new MSI Mega Stick 511 USB 2.0 Mass storage device. In my laptop I have
> USB 2.0 port (Acer TM242), when I connect device, only uhci_hcd driver detect
> device. Does anyone have some suggestions? Thanks.

Is the ehci-hcd driver loaded?  And is your device a high speed one?
USB 2.0 support does not mean that it actually goes at high speeds, I
have a USB 2.0 "compliant" low speed USB keyboard here :)

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTJ2XbT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 18:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTJ2XbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 18:31:19 -0500
Received: from mail.kroah.org ([65.200.24.183]:22172 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261973AbTJ2XbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 18:31:18 -0500
Date: Wed, 29 Oct 2003 15:30:19 -0800
From: Greg KH <greg@kroah.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6] fix bug in pci_setup_bridge()
Message-ID: <20031029233018.GA1707@kroah.com>
References: <20031022182537.A5277@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031022182537.A5277@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 22, 2003 at 06:25:37PM +0400, Ivan Kokshaysky wrote:
> This bug prevents Alphas with older firmware from booting if there
> is a card with PCI-PCI bridge that supports 32-bit IO.

Thanks, I've applied this and will send it to Linus in a bit.

greg k-h

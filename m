Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263077AbVGNTia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbVGNTia (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbVGNTgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:36:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:52697 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263086AbVGNTd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:33:57 -0400
Date: Thu, 14 Jul 2005 12:33:52 -0700
From: Greg KH <greg@kroah.com>
To: Adam Belay <abelay@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] add PCI bus registration support [2/9]
Message-ID: <20050714193351.GB31595@kroah.com>
References: <1121331313.3398.90.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121331313.3398.90.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 04:55:12AM -0400, Adam Belay wrote:
> +EXPORT_SYMBOL(pci_add_bus);

This doens't need to be exported, right?  No module uses it.  But if
they do, I suggest EXPORT_SYMBOL_GPL() instead, is that ok?

thanks,

greg k-h

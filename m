Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbULQVrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbULQVrK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 16:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbULQVrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 16:47:10 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:3270 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262169AbULQVq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 16:46:58 -0500
Date: Fri, 17 Dec 2004 13:45:59 -0800
From: Greg KH <greg@kroah.com>
To: David Howells <dhowells@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make pci_set_power_state() check register version
Message-ID: <20041217214559.GA22597@kroah.com>
References: <24151.1103302732@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24151.1103302732@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 04:58:52PM +0000, David Howells wrote:
> 
> The attached patch makes pci_set_power_state() check the PM register version
> and ignore non-version 2 registers. Trampling on earlier version PM registers
> such as are sported by the Promise 20269 IDE card can cause the system to
> hang.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>

Applied, thanks.

greg k-h

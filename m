Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVBHAjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVBHAjb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 19:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVBHAja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 19:39:30 -0500
Received: from mail.kroah.org ([69.55.234.183]:4261 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261352AbVBHAjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 19:39:23 -0500
Date: Mon, 7 Feb 2005 16:19:54 -0800
From: Greg KH <greg@kroah.com>
To: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
Cc: John Rose <johnrose@austin.ibm.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       LKML <linux-kernel@vger.kernel.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
Subject: Re: [PATCH] PCI: fix pci_remove_legacy_files() crash
Message-ID: <20050208001954.GA28803@kroah.com>
References: <87zmyl2ecb.wl%muneda.takahiro@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zmyl2ecb.wl%muneda.takahiro@jp.fujitsu.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 12:28:36PM +0900, MUNEDA Takahiro wrote:
> Hi,
> 
> The legacy_io which is the member of pci_bus struct might be
> NULL. It should be checked.
> 
> This patch checks 'b->legacy_io', NULL or not.
> 
> Signed-off-by: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>

Applied, thanks.

greg k-h

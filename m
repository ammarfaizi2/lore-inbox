Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTFKUMT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTFKUMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:12:19 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:19441 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263590AbTFKUMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:12:17 -0400
Date: Wed, 11 Jun 2003 13:28:11 -0700
From: Greg KH <greg@kroah.com>
To: Miles Lane <miles.lane@attbi.com>, willy@debian.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Looks like your PCI patch broke the PPC build (and others)?
Message-ID: <20030611202811.GA26387@kroah.com>
References: <3EE77FD6.9020502@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE77FD6.9020502@attbi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 12:15:34PM -0700, Miles Lane wrote:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=105527406918793&w=2
> 
>   CC      drivers/pci/probe.o
> drivers/pci/probe.c: In function `pci_scan_device':
> drivers/pci/probe.c:532: dereferencing pointer to incomplete type
> make[3]: *** [drivers/pci/probe.o] Error 1

Not my patch, Matthew's :)

I think the PPC developers have a fix for this.

thanks,

greg k-h

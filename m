Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264933AbUGBVEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbUGBVEu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 17:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbUGBVDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 17:03:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:30596 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264933AbUGBVCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 17:02:42 -0400
Date: Fri, 2 Jul 2004 13:56:30 -0700
From: Greg KH <greg@kroah.com>
To: linas@austin.ibm.com
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 PCI Hotplug null pointer deref
Message-ID: <20040702205630.GC29580@kroah.com>
References: <20040701181605.M21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701181605.M21634@forte.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 06:16:05PM -0500, linas@austin.ibm.com wrote:
> 
> Greg,
> 
> Please review the attached patch and, if acceptable, apply to the 
> akpm/otrvalds/bkbits kernel tree.
> 
> This patch fixes a null-pointer dereference when hot-plug operations 
> are performed on a machine that has virtual-io devices in it.  
> Virtual i/o devices to not have pci bridges associated with them.
> It also corrects an ordering problem during hotplug remove.
> 
> This patch was previously reviewed/tested by Linda Xie, the current
> rpaphp maintainer.
> 
> --linas
> 
> Signed-off-by: Linas Vepstas <linas@linas.org>

Applied, thanks.

greg k-h

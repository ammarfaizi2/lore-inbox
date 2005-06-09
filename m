Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbVFIQ6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbVFIQ6H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 12:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVFIQ6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 12:58:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:52410 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262273AbVFIQ6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 12:58:02 -0400
Date: Thu, 9 Jun 2005 09:57:58 -0700
From: Greg KH <greg@kroah.com>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 04/10] IOCHK interface for I/O error handling/detecting
Message-ID: <20050609165758.GD9597@kroah.com>
References: <42A8386F.2060100@jp.fujitsu.com> <42A83BC8.2010500@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A83BC8.2010500@jp.fujitsu.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 09:53:28PM +0900, Hidetoshi Seto wrote:
> +	/* there is no bridge */
> +	if (!dev->bus->self) return NULL;

Put the "return NULL;" on it's own line please.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVGGTSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVGGTSA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 15:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVGGTNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 15:13:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:39126 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262206AbVGGTMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 15:12:02 -0400
Date: Thu, 7 Jul 2005 11:41:02 -0700
From: Greg KH <greg@kroah.com>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
       Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 2.6.13-rc1 01/10] IOCHK interface for I/O error handling/detecting
Message-ID: <20050707184102.GC14726@kroah.com>
References: <42CB63B2.6000505@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CB63B2.6000505@jp.fujitsu.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 01:53:06PM +0900, Hidetoshi Seto wrote:
> Hi all,
> 
> The followings are updated version of patches I've posted to
> implement IOCHK interface for I/O error handling/detecting.
> 
> The abstraction of patches hasn't changed, so please refer
> archives if you need, e.g.: http://lwn.net/Articles/139240/

How about the issue of tying this into the other pci error reporting
infrastructure that is being worked on?

thanks,

greg k-h

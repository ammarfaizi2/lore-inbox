Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWERQQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWERQQa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 12:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWERQQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 12:16:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:56808 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751370AbWERQQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 12:16:29 -0400
Date: Thu, 18 May 2006 08:56:09 -0700
From: Greg KH <gregkh@suse.de>
To: "Brown, Len" <len.brown@intel.com>
Cc: ak@suse.de, torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.6.17] [3/5] i386/x86_64: Force pci=noacpi on HP  XW9300
Message-ID: <20060518155609.GC13334@suse.de>
References: <CFF307C98FEABE47A452B27C06B85BB670FA6C@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB670FA6C@hdsmsx411.amr.corp.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 12:47:31PM -0400, Brown, Len wrote:
> 
> >The system has multiple PCI segments and we don't handle that properly
> >yet in PCI and ACPI. Short term before this is fixed blacklist it to
> >pci=noacpi.
> 
> I'm okay with the patch, but it makes me wonder...
> 
> Is this the 1st/only system Linux has run on with multiple PCI segments?
> What are your expectations for where "short-term" ends and "long-term"
> begins?

Jeff's older patches caused some bad problems on some odd NUMA machines,
so I dropped them.  Someone needs to take the time and clean them all up
and get them working properly and included into the tree.

Right now, it's very low on my todo list as I don't have such a machine.

thanks,

greg k-h

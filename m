Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264853AbUGNXNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264853AbUGNXNJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 19:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266009AbUGNXLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 19:11:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:31445 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266010AbUGNXJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 19:09:13 -0400
Date: Wed, 14 Jul 2004 15:53:09 -0700
From: Greg KH <greg@kroah.com>
To: Linda Xie <lxiep@us.ibm.com>
Cc: Hotplug List <pcihpd-discuss@lists.sourceforge.net>,
       John Rose <johnrose@austin.ibm.com>, Mike Wortman <wortman@us.ibm.com>,
       External List <linuxppc64-dev@lists.linuxppc.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATH] rpaphp_add_slot.patch
Message-ID: <20040714225309.GD3398@kroah.com>
References: <40E5E5A1.4080003@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40E5E5A1.4080003@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 05:45:53PM -0500, Linda Xie wrote:
> Hi Greg,
> 
> I found a bug in rpaphp code during DLPAR I/O testing.   When DLPAR ADD 
> a non-empty I/O slot to a partition,  an adapter  in the slot  didn't 
> get configured. The attached patch fixes that. Please review  and apply 
> if there are no objections.
> 
> Signed-off-by: Linda Xie <lxie@us.ibm.com>  

Applied, thanks.

greg k-h

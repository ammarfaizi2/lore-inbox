Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266904AbUBEVvk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUBEVvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:51:39 -0500
Received: from mail.kroah.org ([65.200.24.183]:44485 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266904AbUBEVvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:51:38 -0500
Date: Thu, 5 Feb 2004 13:51:38 -0800
From: Greg KH <greg@kroah.com>
To: "King, Steven R" <steven.r.king@intel.com>
Cc: linux-kernel@vger.kernel.org, infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Message-ID: <20040205215138.GD15718@kroah.com>
References: <33561BB7A415E04FBDC339D5E149C6E26C38FE@orsmsx405.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33561BB7A415E04FBDC339D5E149C6E26C38FE@orsmsx405.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 11:38:44AM -0800, King, Steven R wrote:
> We just use the kernel's spin_lock_irqsave(), so I don't know what
> you're talking about.

If you peruse the section, "The Fucked Up Sparc" in
Documentation/DocBook/kernel-locking you will see the problem.

thanks,

greg k-h

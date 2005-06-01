Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVFAVRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVFAVRB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVFAVOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 17:14:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:50832 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261240AbVFAVOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 17:14:04 -0400
Date: Wed, 1 Jun 2005 14:24:18 -0700
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Don't "lose" devices on suspend on failure
Message-ID: <20050601212418.GA3936@kroah.com>
References: <1117523329.5826.14.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117523329.5826.14.camel@gaston>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 05:08:49PM +1000, Benjamin Herrenschmidt wrote:
> Hi !
> 
> I think we need this patch or we might "lose" devices to the dpm_irq_off
> list if a failure occurs during the suspend process.
> 
> Patrick, Greg, your opinion ?

Looks fine to me, I've added it to my tree.

thanks,

greg k-h
